#!/bin/bash
 ps -ax | grep ElmerSolver | awk '{print $1}' | xargs -L1 kill -9
