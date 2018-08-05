# Introduction

## A dynamic language for system programming

## Background: Lua, LuaJIT, RaptorJIT


# How the JIT compiler works

## Traces: the basic unit of compilation

## How traces are compiled

## How traces are optimized


# How to write efficient programs

## Stay "on trace"

### Make types consistent

### Make control flow consistent

## Allocate objects appropriately

## Minimize "boxing" of 64-bit values

## Control memory layout with FFI


# How to profile a program

## Getting Auditlog and VMProfile diagnostic data

## Exploring data interactively with *Studio*

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

