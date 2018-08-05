# Introduction

## A simple dynamic language for system programming

## Lua, LuaJIT, RaptorJIT


# How the JIT compiler works

## What gets compiled

## What gets optimized

## How compilation happens


# How to write efficient programs

## Make types consistent

## Make control flow consistent

## Allocate objects appropriately

## Minimize "boxing" of 64-bit values

## Control memory layout with FFI


# What diagnostic data the runtime system produces

## Tracing with auditlog

## Profiling with VMProfile


# How to inspect diagnostic data

## Interactive inspection with *Studio*

### Reviewing the audit log

### Reviewing the profiler samples

### Inspecting a trace

#### JIT events

#### Bytecode

#### Intermediate code

#### Machine code

## Exporting data in other formats

### Human readable text

### Machine readable


# How to optimize a program

## A top-down workflow

## External library calls

## Interpreting bytecode

## Garbage collection

## Trace head verses loop

## IR and machine code

