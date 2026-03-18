# RFC XML Round-Trip Test Script

## Purpose

Test round-trip parsing of RFC XML v3 files using Canon gem for semantic comparison.

**Process:** XML → Parse → Serialize → Compare

## Usage

```bash
# Test single file
ruby scripts/roundtrip_test.rb spec/xmlsource-rfc8650-latest/rfc8704.xml

# Test multiple files
ruby scripts/roundtrip_test.rb file1.xml file2.xml file3.xml

# Test all files in directory
ruby scripts/roundtrip_test.rb spec/xmlsource-rfc8650-latest/

# Test with glob pattern
ruby scripts/roundtrip_test.rb "spec/xmlsource-rfc8650-latest/rfc87*.xml"

# Test all 920 files (default)
ruby scripts/roundtrip_test.rb
```

## Environment Variables

| Variable  | Default | Description                    |
|-----------|---------|--------------------------------|
| `THREADS` | 8       | Number of worker threads       |
| `VERBOSE` | false   | Show per-file progress         |

```bash
THREADS=1 VERBOSE=1 ruby scripts/roundtrip_test.rb file.xml
```

## Output

Test results are written to `tmp/roundtrip-results-{timestamp}/`:

```
tmp/roundtrip-results-20260318_200000/
  SUMMARY.yml              # Overall summary (YAML)
  PASS_{filename}          # Empty marker for passed tests
  FAIL_{filename}.yml      # Structured failure details
  ERROR_{filename}.yml     # Structured error details
  SOURCE_{filename}        # Round-tripped output for debugging
```

### SUMMARY.yml Structure

```yaml
timestamp: "2026-03-18T20:00:00+08:00"
configuration:
  threads: 8
  files_tested: 920
  elapsed_seconds: 664.75
results:
  passed: 833
  failed: 83
  errors: 4
  pass_rate: "90.5%"
failed_files:
  - rfc8704.xml
  - rfc8705.xml
error_files:
  - rfc8650.xml
```

### FAIL_*.yml Structure

```yaml
source_file: spec/xmlsource-rfc8650-latest/rfc8704.xml
status: failed
normative_differences: 1
total_differences: 267
differences:
  - path: /rfc[1]/back[1]/references/reference/front/author
    dimension: attribute_presence
    reason: "only in first: initials, surname"
    normative: true
    formatting:
    attributes_before: { initials: "", surname: "" }
    attributes_after: {}
```

## Known Issues

### Threading Bug (4 files)

When using `THREADS > 1`, some files fail with:
```
NoMethodError: undefined method 'transform' for nil
```

Affected files: rfc8650.xml, rfc8651.xml, rfc8654.xml, rfc8657.xml

**Workaround:** Use `THREADS=1` for these files.

### Empty Attribute Handling

Some models need `value_map: { to: { empty: :empty } }` to preserve empty string attributes during round-trip.

## Dependencies

- `rfcxml` gem - RFC XML parsing
- `canon` gem - Semantic XML comparison
- `lutaml-model` - XML serialization
