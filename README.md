# Unified RML launcher

## Setup

```
make

make help                          # Show these help instructions
make setup_rmlmapper_6.1.3         # Install this specific version of RMLMapper
make setup_carml_1.1.9             # Install this specific version of carml
make setup_sdm-rdfizer_latest      # Install the latest version of SDM RDFizer via pip
make setup_morph-kgc_latest        # Install the latest version of Morph-KGC via pip
```

## CLI

Once one or more tools have been set up, the corresponding launchers in the [/bin](/bin) folder can be used.
In the example below, `my-rml-mapper` is a placeholder for any concrete tool such as RMLMapper, Carml, etc.
The set of common options are:

```
my-rml-mapper

my-rml-mapper [options] mapping-file -- Unified RML wrapper launcher

where options are:
    -u --unique          Use the tools native distinct feature (fails if unsupported)
    -s --sort            Use the tools native sorting feature (fails if unsupported)
    -l --large           Use the tools native large file feature
    -m --memory          Configure the tool for the given amount of memory in GIGABYTES.
       --out-file=path   Write output to the specified file. IMPORTANT: the '=' is mandatory.
       --out-format=fmt  (not yet supported; defaults to nquads)
    -k --keep            Keep temporary resources, such as generated config files, rather then removing them when done
    -x                   Enable bash debugging (set -x)

No arguments provided

```


