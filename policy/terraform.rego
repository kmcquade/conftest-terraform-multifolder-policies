package terraform

import input

# `resource_changes` builds a list of all resource change objects
# found in the input document. This does not to anything with modules.
# This should be shared/imported with pretty much all the other modules
resource_changes[r] {
	r := input.resource_changes[_]
}
