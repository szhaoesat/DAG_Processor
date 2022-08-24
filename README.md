# Energy-efficient execution of irregular directed acyclic graphs

The paper proposes a customized parallel architecture for energy-efficient execution of irregular directed acyclic graphs (DAG) from probabilistic machine learning and sparse linear algebra. A targeted compiler is developed to generate a binary program for the custom processor given an arbitrary DAG.

#### Aim of the experiments
The processor performance reported in the paper are reproduced through SystemVerilog RTL simulation. The processor instructions for the target workloads are generated with the custom compiler, validating the compilation algorithm.

### This codebase includes the following components:
1) SystemVerilog-based microarchitectural RTL model of the processor (in [./hw/rtl/](https://github.com/nimish15shah/DAG_Processor/tree/main/hw/rtl)) and a testbench (in [./hw/tb/](https://github.com/nimish15shah/DAG_Processor/tree/main/hw/tb)).
2) A Python-based compiler (in [./src/](https://github.com/nimish15shah/DAG_Processor/tree/main/src)).
3) Input DAGs to reproduce the experiments (in [./data/](https://github.com/nimish15shah/DAG_Processor/tree/main/data))

### Dependencies
* Synopsys VCS simulator (proprietary): Used for SystemVerilog simulation.
* Bash, version 4 (or zsh)
* (Optional) Anaconda3: For Linux installation, see https://docs.anaconda.com/anaconda/install/linux/#installation
* For the flow without Anaconda3, Pthon 3.7.7 should be used. Later vesions may also work, but this flow is tested with 3.7.7.

## With Anaconda (Recommended)
```
# Installation
git clone git@github.com:nimish15shah/DAG_Processor.git
cd DAG_Processor
conda create --name DAGprocessor --file conda-linux-64.yml

# Run experiments
conda activate DAGprocessor
./run.sh 
```

## Without Anaconda
You can also run the experiment without Anaconda but using a Python virtual environment (Python version 3.7.7 is recommended):
```
# Installation
git clone git@github.com:nimish15shah/DAG_Processor.git
cd DAG_Processor
python3 -m venv venv_DAGprocessor
./venv_DAGprocessor/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# Run experiments
./run.sh noconda 
```

**Disk space requirement**: Less than 200MB (not including Anaconda and Synopsys VCS installation).

**Experiments runtime**: 3-4 hours.

**With zsh**: Run the script as `zsh run.sh` or `zsh run.sh noconda` .

## Workflow
The run script perfroms the following steps:
- Activate the Conda Python environment or a Python virtual enviornment. If you are using a new Conda installation this might require running `conda init bash` first.
- The python-based compiler takes the DAG benchmarks as input and generates binary programs for each benchmark. 
- The SystemVerilog testbench reads the binary programs and the data input files generated by the compiler, and executes the RTL simulation (with the proprietary Synopsys VCS simulator) and generates the latency log. 
- Finally the charts are plotted according to the data collected during the compilation and RTL simulations.



### Outputs
The output charts are available at ```./out/plots```.
- The results of fig. 14 of the paper is reproduced in the ```./out/plots/instruction_breakdown.pdf``` file.
- The results of our processor in fig. 15(a) of the paper is reproduced in the ```./out/plots/throughput.pdf``` file. Throughputs of the rest of the platforms are not reproduced in this codebase and are plotted from a fixed table.

Note: The large DAGs ("Large PC") from table 1 in the paper are not evaluated in this version of the codebase due to large experimental runtime (>24hours).
