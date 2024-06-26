import os
import platform

from twisted.internet import defer

from .. import data, helper
from p2pool.util import pack


P2P_PREFIX = 'f4b5f3f4'.decode('hex')
P2P_PORT = 18333
ADDRESS_VERSION = 111
RPC_PORT = 18332
RPC_CHECK = defer.inlineCallbacks(lambda bitcoind: defer.returnValue(
            'getblocktemplate' in (yield bitcoind.rpc_help()) and
            (yield bitcoind.rpc_getblockchaininfo())['chain'] == 'test'
        ))
SUBSIDY_FUNC = lambda height: 50*100000000 >> (height + 1)//210000
POW_FUNC = data.hash256
BLOCK_PERIOD = 600 # s
SYMBOL = 'tFCH'
CONF_FILE_FUNC = lambda: os.path.join(os.path.join(os.environ['APPDATA'], 'Freecash') if platform.system() == 'Windows' else os.path.expanduser('~/Library/Application Support/Freecash/') if platform.system() == 'Darwin' else os.path.expanduser('~/.freecash'), 'freecash.conf')
BLOCK_EXPLORER_URL_PREFIX = 'http://blockexplorer.com/testnet/block/'
ADDRESS_EXPLORER_URL_PREFIX = 'http://blockexplorer.com/testnet/address/'
TX_EXPLORER_URL_PREFIX = 'http://blockexplorer.com/testnet/tx/'
SANE_TARGET_RANGE = (2**256//2**32//1000 - 1, 0xb6666ffffffffffffffffffffffffffffffffffffffffffffffffffff)
DUMB_SCRYPT_DIFF = 1
DUST_THRESHOLD = 1e8
