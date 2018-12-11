##########################################################################################
# Credit: https://github.com/johanhaleby/kubetail
##########################################################################################
# # # # # # # # # # # Apache License
# # # # # # # # # Version 2.0, January 2004
# # # # # # # # http://www.apache.org/licenses/

# TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

# 1. Definitions.

# # "License" shall mean the terms and conditions for use, reproduction,
# # and distribution as defined by Sections 1 through 9 of this document.

# # "Licensor" shall mean the copyright owner or entity authorized by
# # the copyright owner that is granting the License.

# # "Legal Entity" shall mean the union of the acting entity and all
# # other entities that control, are controlled by, or are under common
# # control with that entity. For the purposes of this definition,
# # "control" means (i) the power, direct or indirect, to cause the
# # direction or management of such entity, whether by contract or
# # otherwise, or (ii) ownership of fifty percent (50%) or more of the
# # outstanding shares, or (iii) beneficial ownership of such entity.

# # "You" (or "Your") shall mean an individual or Legal Entity
# # exercising permissions granted by this License.

# # "Source" form shall mean the preferred form for making modifications,
# # including but not limited to software source code, documentation
# # source, and configuration files.

# # "Object" form shall mean any form resulting from mechanical
# # transformation or translation of a Source form, including but
# # not limited to compiled object code, generated documentation,
# # and conversions to other media types.

# # "Work" shall mean the work of authorship, whether in Source or
# # Object form, made available under the License, as indicated by a
# # copyright notice that is included in or attached to the work
# # (an example is provided in the Appendix below).

# # "Derivative Works" shall mean any work, whether in Source or Object
# # form, that is based on (or derived from) the Work and for which the
# # editorial revisions, annotations, elaborations, or other modifications
# # represent, as a whole, an original work of authorship. For the purposes
# # of this License, Derivative Works shall not include works that remain
# # separable from, or merely link (or bind by name) to the interfaces of,
# # the Work and Derivative Works thereof.

# # "Contribution" shall mean any work of authorship, including
# # the original version of the Work and any modifications or additions
# # to that Work or Derivative Works thereof, that is intentionally
# # submitted to Licensor for inclusion in the Work by the copyright owner
# # or by an individual or Legal Entity authorized to submit on behalf of
# # the copyright owner. For the purposes of this definition, "submitted"
# # means any form of electronic, verbal, or written communication sent
# # to the Licensor or its representatives, including but not limited to
# # communication on electronic mailing lists, source code control systems,
# # and issue tracking systems that are managed by, or on behalf of, the
# # Licensor for the purpose of discussing and improving the Work, but
# # excluding communication that is conspicuously marked or otherwise
# # designated in writing by the copyright owner as "Not a Contribution."

# # "Contributor" shall mean Licensor and any individual or Legal Entity
# # on behalf of whom a Contribution has been received by Licensor and
# # subsequently incorporated within the Work.

# 2. Grant of Copyright License. Subject to the terms and conditions of
# # this License, each Contributor hereby grants to You a perpetual,
# # worldwide, non-exclusive, no-charge, royalty-free, irrevocable
# # copyright license to reproduce, prepare Derivative Works of,
# # publicly display, publicly perform, sublicense, and distribute the
# # Work and such Derivative Works in Source or Object form.

# 3. Grant of Patent License. Subject to the terms and conditions of
# # this License, each Contributor hereby grants to You a perpetual,
# # worldwide, non-exclusive, no-charge, royalty-free, irrevocable
# # (except as stated in this section) patent license to make, have made,
# # use, offer to sell, sell, import, and otherwise transfer the Work,
# # where such license applies only to those patent claims licensable
# # by such Contributor that are necessarily infringed by their
# # Contribution(s) alone or by combination of their Contribution(s)
# # with the Work to which such Contribution(s) was submitted. If You
# # institute patent litigation against any entity (including a
# # cross-claim or counterclaim in a lawsuit) alleging that the Work
# # or a Contribution incorporated within the Work constitutes direct
# # or contributory patent infringement, then any patent licenses
# # granted to You under this License for that Work shall terminate
# # as of the date such litigation is filed.

# 4. Redistribution. You may reproduce and distribute copies of the
# # Work or Derivative Works thereof in any medium, with or without
# # modifications, and in Source or Object form, provided that You
# # meet the following conditions:

# # (a) You must give any other recipients of the Work or
# # #  Derivative Works a copy of this License; and

# # (b) You must cause any modified files to carry prominent notices
# # #  stating that You changed the files; and

# # (c) You must retain, in the Source form of any Derivative Works
# # #  that You distribute, all copyright, patent, trademark, and
# # #  attribution notices from the Source form of the Work,
# # #  excluding those notices that do not pertain to any part of
# # #  the Derivative Works; and

# # (d) If the Work includes a "NOTICE" text file as part of its
# # #  distribution, then any Derivative Works that You distribute must
# # #  include a readable copy of the attribution notices contained
# # #  within such NOTICE file, excluding those notices that do not
# # #  pertain to any part of the Derivative Works, in at least one
# # #  of the following places: within a NOTICE text file distributed
# # #  as part of the Derivative Works; within the Source form or
# # #  documentation, if provided along with the Derivative Works; or,
# # #  within a display generated by the Derivative Works, if and
# # #  wherever such third-party notices normally appear. The contents
# # #  of the NOTICE file are for informational purposes only and
# # #  do not modify the License. You may add Your own attribution
# # #  notices within Derivative Works that You distribute, alongside
# # #  or as an addendum to the NOTICE text from the Work, provided
# # #  that such additional attribution notices cannot be construed
# # #  as modifying the License.

# # You may add Your own copyright statement to Your modifications and
# # may provide additional or different license terms and conditions
# # for use, reproduction, or distribution of Your modifications, or
# # for any such Derivative Works as a whole, provided Your use,
# # reproduction, and distribution of the Work otherwise complies with
# # the conditions stated in this License.

# 5. Submission of Contributions. Unless You explicitly state otherwise,
# # any Contribution intentionally submitted for inclusion in the Work
# # by You to the Licensor shall be under the terms and conditions of
# # this License, without any additional terms or conditions.
# # Notwithstanding the above, nothing herein shall supersede or modify
# # the terms of any separate license agreement you may have executed
# # with Licensor regarding such Contributions.

# 6. Trademarks. This License does not grant permission to use the trade
# # names, trademarks, service marks, or product names of the Licensor,
# # except as required for reasonable and customary use in describing the
# # origin of the Work and reproducing the content of the NOTICE file.

# 7. Disclaimer of Warranty. Unless required by applicable law or
# # agreed to in writing, Licensor provides the Work (and each
# # Contributor provides its Contributions) on an "AS IS" BASIS,
# # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# # implied, including, without limitation, any warranties or conditions
# # of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
# # PARTICULAR PURPOSE. You are solely responsible for determining the
# # appropriateness of using or redistributing the Work and assume any
# # risks associated with Your exercise of permissions under this License.

# 8. Limitation of Liability. In no event and under no legal theory,
# # whether in tort (including negligence), contract, or otherwise,
# # unless required by applicable law (such as deliberate and grossly
# # negligent acts) or agreed to in writing, shall any Contributor be
# # liable to You for damages, including any direct, indirect, special,
# # incidental, or consequential damages of any character arising as a
# # result of this License or out of the use or inability to use the
# # Work (including but not limited to damages for loss of goodwill,
# # work stoppage, computer failure or malfunction, or any and all
# # other commercial damages or losses), even if such Contributor
# # has been advised of the possibility of such damages.

# 9. Accepting Warranty or Additional Liability. While redistributing
# # the Work or Derivative Works thereof, You may choose to offer,
# # and charge a fee for, acceptance of support, warranty, indemnity,
# # or other liability obligations and/or rights consistent with this
# # License. However, in accepting such obligations, You may act only
# # on Your own behalf and on Your sole responsibility, not on behalf
# # of any other Contributor, and only if You agree to indemnify,
# # defend, and hold each Contributor harmless for any liability
# # incurred by, or claims asserted against, such Contributor by reason
# # of your accepting any such warranty or additional liability.

# END OF TERMS AND CONDITIONS

# APPENDIX: How to apply the Apache License to your work.

# # To apply the Apache License to your work, attach the following
# # boilerplate notice, with the fields enclosed by brackets "{}"
# # replaced with your own identifying information. (Don't include
# # the brackets!)  The text should be enclosed in the appropriate
# # comment syntax for the file format. We also recommend that a
# # file or class name and description of purpose be included on the
# # same "printed page" as the copyright notice for easier
# # identification within third-party archives.

# Copyright {yyyy} {name of copyright owner}

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# #  http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################################

#!/bin/bash

readonly PROGNAME=$(basename $0)

default_since="10s"
default_namespace="default"
default_line_buffered=""
default_colored_output="line"

line_buffered="${default_line_buffered}"
colored_output="${default_colored_output}"

pod="${1}"
containers=()
selector=()
since="${default_since}"
version="1.2.2-SNAPSHOT"

usage="${PROGNAME} <search term> [-h] [-c] [-n] [-t] [-l] [-s] [-b] [-k] [-v] -- tail multiple Kubernetes pod logs at the same time

where:
    -h, --help           Show this help text
    -c, --container      The name of the container to tail in the pod (if multiple containers are defined in the pod).
                         Defaults to all containers in the pod. Can be used multiple times.
    -t, --context        The k8s context. ex. int1-context. Relies on ~/.kube/config for the contexts.
    -l, --selector       Label selector. If used the pod name is ignored.
    -n, --namespace      The Kubernetes namespace where the pods are located (defaults to \"default\")
    -s, --since          Only return logs newer than a relative duration like 5s, 2m, or 3h. Defaults to 10s.
    -b, --line-buffered  This flags indicates to use line-buffered. Defaults to false.
    -k, --colored-output Use colored output (pod|line|false).
                         pod = only color podname, line = color entire line, false = don't use any colors.
                         Defaults to line.
    -v, --version 	 Prints the kubetail version 

examples:
    ${PROGNAME} my-pod-v1
    ${PROGNAME} my-pod-v1 -c my-container
    ${PROGNAME} my-pod-v1 -t int1-context -c my-container
    ${PROGNAME} -l service=my-service
    ${PROGNAME} --selector service=my-service --since 10m"

if [ $# -eq 0 ]; then
	echo "$usage"
	exit 1
fi

if [ "$#" -ne 0 ]; then
	while [ "$#" -gt 0 ]
	do
		case "$1" in
		-h|--help)
			echo "$usage"
			exit 0
			;;
		-v|--version)
			echo "$version"
			exit 0
			;;
		-c|--container)
			containers+=("$2")
			;;
		-t|--context)
			context="$2"
			;;
		-l|--selector)
			selector=(--selector "$2")
			pod=""
			;;
		-s|--since)
			if [ -z "$2" ]; then
				since="${default_since}"
			else
				since="$2"
			fi
			;;
		-n|--namespace)
			if [ -z "$2" ]; then
				namespace="${default_namespace}"
			else
				namespace="$2"
			fi
			;;
		-b|--line-buffered)
			if [ "$2" = "true" ]; then
				line_buffered="| grep - --line-buffered"
			fi
			;;
		-k|--colored-output)
			if [ -z "$2" ]; then
				colored_output="${default_colored_output}"
			else
				colored_output="$2"
			fi
			;;
		--)
			break
			;;
		-*)
			echo "Invalid option '$1'. Use --help to see the valid options" >&2
			exit 1
			;;
		# an option argument, continue
		*)  ;;
		esac
		shift
	done
fi

# Join function that supports a multi-character seperator (copied from http://stackoverflow.com/a/23673883/398441)
function join() {
	# $1 is return variable name
	# $2 is sep
	# $3... are the elements to join
	local retname=$1 sep=$2 ret=$3
	shift 3 || shift $(($#))
	printf -v "$retname" "%s" "$ret${@/#/$sep}"
}

# Get all pods matching the input and put them in an array. If no input then all pods are matched.
matching_pods=(`kubectl get pods --context=${context} "${selector[@]}" --namespace=${namespace} --output=jsonpath='{.items[*].metadata.name}' | xargs -n1 | grep "${pod}"`)
matching_pods_size=${#matching_pods[@]}

if [ ${matching_pods_size} -eq 0 ]; then
	echo "No pods exists that matches ${pod}"
	exit 1
fi

color_end=$(tput sgr0)

# Wrap all pod names in the "kubectl logs <name> -f" command
display_names_preview=()
pod_logs_commands=()
i=0

# Allows for more colors, this is useful if one tails a lot pods
if [ ${colored_output} != "false" ]; then
	export TERM=xterm-256color
fi

for pod in ${matching_pods[@]}; do
	if [ ${#containers[@]} -eq 0 ]; then
		pod_containers=($(kubectl get pod ${pod} --context=${context} --output=jsonpath='{.spec.containers[*].name}' --namespace=${namespace} | xargs -n1))
	else
		pod_containers=("${containers[@]}")
	fi

	for container in ${pod_containers[@]}; do
		if [ ${colored_output} == "false" ] || [ ${matching_pods_size} -eq 1 -a ${#pod_containers[@]} -eq 1 ]; then
			color_start=$(tput sgr0)
		else
			if [ $i -gt 5 ]; then
				# If index is more than 5 we skip the next two colors since color 6 is beige 
				# (which is hard to see when using white or solarized background) and 7 is black
				# (which is hard to see when using black background)
				color_index=$(($i+3))
			else
				color_index=$(($i+1))
			fi
			color_start=$(tput setaf $color_index)
		fi

		if [ ${#pod_containers[@]} -eq 1 ]; then
			display_name="${pod}"
		else
			display_name="${pod} ${container}"
		fi
		display_names_preview+=("${color_start}${display_name}${color_end}")

		if [ ${colored_output} == "pod" ]; then
			colored_line="${color_start}[${display_name}]${color_end} \$line"
		else
			colored_line="${color_start}[${display_name}] \$line ${color_end}"
		fi

		logs_commands+=("kubectl --context=${context} logs ${pod} ${container} -f --since=${since} --namespace=${namespace} | while read line; do echo \"$colored_line\"; done");

		i=$(($i + 1))
	done
done

# Preview pod colors
echo "Will tail ${i} logs..."
for preview in "${display_names_preview[@]}"; do
	echo "$preview"
done

# Join all log commands into one string seperated by " & "
join command_to_tail " & " "${logs_commands[@]}"

# Aggreate all logs and print to stdout
CMD="cat <( eval "${command_to_tail}" ) $line_buffered"
eval "$CMD"
