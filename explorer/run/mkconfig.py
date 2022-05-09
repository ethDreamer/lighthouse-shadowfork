#!/usr/bin/env python3
import sys, os
import ruamel.yaml

def sanitize(unclean):
    return ''.join(c for c in unclean if c.isprintable() or c == "\n")

def read_yaml(file):
    with open(file) as f:
        return ruamel.yaml.round_trip_load(sanitize(f.read()), preserve_quotes=True)

def fix_hex(hexint):
    return "0x{:02x}".format(hexint)

def forktitle():
    return os.environ['ETH2_TESTNET'].replace("-", " ").title()

def get_deploy_block(eth2_config_file):
    if "DEPOSIT_DEPLOY_BLOCK" in os.environ:
        return os.environ['DEPOSIT_DEPLOY_BLOCK']
    eth2_config_dir = os.path.dirname(eth2_config_file)
    deploy_file = os.path.join(eth2_config_dir, 'deploy_block.txt')
    if os.path.exists(deploy_file):
        with open(deploy_file) as f:
            return int(f.read())
    return 0

def main():
    if len(sys.argv) < 3:
        print("usage: {} [ETH2_CONFIG] [EXPLORER_CONFIG]".format(sys.argv[0]))
        sys.exit(1)
    eth2_config_file = sys.argv[1]
    expl_config_file = sys.argv[2]
    eth2_config = read_yaml(eth2_config_file)
    config      = read_yaml(expl_config_file)

    config['database']['user'] = os.environ['POSTGRES_USER']
    config['database']['name'] = os.environ['POSTGRES_DB']
    config['database']['host'] = "postgres"
    config['database']['port'] = 5432
    config['database']['password'] = os.environ['POSTGRES_PASSWORD']

    config['chain']['secondsPerSlot'] = eth2_config['SECONDS_PER_SLOT']
    config['chain']['genesisTimestamp'] = eth2_config['MIN_GENESIS_TIME']
    config['chain']['minGenesisActiveValidatorCount'] = eth2_config['MIN_GENESIS_ACTIVE_VALIDATOR_COUNT']
    config['chain']['altairForkEpoch'] = eth2_config['ALTAIR_FORK_EPOCH']
    config['chain']['phase0path'] = eth2_config_file
#    config['chain']['altairPath'] = eth2_config_file
    if 'altairPath' in config['chain']:
        del config['chain']['altairPath']

    config['frontend']['imprint'] = "templates/imprint.example.html"
    config['frontend']['siteName'] = "Ethereum 2.0 Beacon Chain Explorer ({})".format(forktitle())
    config['frontend']['siteSubtitle'] = "Showing the {} Testnet".format(forktitle())
    config['frontend']['server']['host'] = "0.0.0.0"
    config['frontend']['server']['port'] = 3333
    config['frontend']['database']['user'] = config['database']['user']
    config['frontend']['database']['name'] = config['database']['name']
    config['frontend']['database']['host'] = config['database']['host']
    config['frontend']['database']['port'] = config['database']['port']
    config['frontend']['database']['password'] = config['database']['password']

    config['indexer']['node']['host'] = "consensus-bn"
    config['indexer']['node']['port'] = 5052
    config['indexer']['node']['type'] = "lighthouse"
    config['indexer']['eth1Endpoint'] = "http://execution:8545"
    config['indexer']['eth1DepositContractAddress'] = fix_hex(eth2_config['DEPOSIT_CONTRACT_ADDRESS'])
    config['indexer']['eth1DepositContractFirstBlock'] = get_deploy_block(eth2_config_file)

    ruamel.yaml.dump(config, sys.stdout, Dumper=ruamel.yaml.RoundTripDumper)


main()

