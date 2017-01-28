# Projects CONSTANTS file
# Contains all constants for ForGen

### Directory constants

## Directory Locations

# Root directory for ForGen
DIR_ROOT = File.expand_path('../../', __FILE__)

# Main Library directory for ForGen
DIR_LIBRARY = DIR_ROOT + '/lib'

# Main Documentation directory for ForGen
DIR_DOCUMENTATION = DIR_ROOT + '/documentation'

# Chosen Output directory path for Documentation
DIR_DOCUMENTATION_OUTPUT_PATH = DIR_DOCUMENTATION + '/yard'

# Chosen Output directory name for Documentation
DIR_DOCUMENTATION_OUTPUT_NAME = '/docs'

# Main Modules directory for ForGen
DIR_MODULES = DIR_ROOT + '/modules'

# Main Mount directory for ForGen
DIR_MOUNT = DIR_ROOT + '/mount'

# Main data_structures directory for ForGen
DIR_DATA_STRUCTURES = DIR_ROOT + '/data_structures'

# Class directory
DIR_CLASSES = DIR_ROOT + '/lib/classes'

# Method libraries directory
DIR_METHOD_LIBRARIES = DIR_ROOT + '/lib/method_libs'

# Template file directory
DIR_TEMPLATE = DIR_ROOT + '/lib/templates'

# Projects directory
DIR_PROJECTS = DIR_ROOT + '/projects'

# Cases directory
DIR_CASES = DIR_ROOT + '/cases'

# Schema directory
DIR_SCHEMA = DIR_ROOT + '/lib/schema'

### Module constants

## Module types

# All module types are listed in the array below
MODULE_TYPES = ['base','build','evidence','forensic','software']

# All packer iso module types are listed in the array below
Packer_ISO_TYPES = ['base']

## Puppet constants

# Puppet version
PUPPET_VERSION = '3.8.7'

# Puppet module types
PUPPET_MODULE_TYPES = ['evidence', 'software', 'forensic','software']

## Version Constants

# Version number
VERSION_NUMBER = '0.0.1'