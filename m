Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A763AC39
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 15:32:57 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202309281532492a9f9682544b2dffb9
        for <xenomai@lists.linux.dev>;
        Thu, 28 Sep 2023 17:32:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yPlvLj7ZXMncjmEhk6RspEdrxA//9wErNIzW+qRvfc8=;
 b=NX3EvoOf45sa2k3FXTDmRwHC31EiIz+een4Sk1k5p9eqPY2CsoSTeCOcYDzsyWDXa97mTz
 5bMgZiTbOV1QZOEWJBN9MH5M9umX8OkgsU/0F2Qm0HI3F2rYmF8qvsbviWcvWqL280pYwSPv
 SY19orXQYE32bdowAbKoETqjsiojE=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/4] Update to kas 4.0
Date: Thu, 28 Sep 2023 17:32:45 +0200
Message-Id: <1814e66721d7ed1307b39f3b271ae8fcb7df0a64.1695915167.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1695915167.git.jan.kiszka@siemens.com>
References: <cover.1695915167.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

At this chance, embed the kas-container script to make boot-strapping
more convenient. This is now the common pattern in Isar layers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md                   |  12 +-
 board-beagle-bone-black.yml |   2 +-
 board-hikey.yml             |   2 +-
 board-qemu-amd64.yml        |   2 +-
 board-qemu-arm64.yml        |   2 +-
 board-qemu-armhf.yml        |   2 +-
 board-x86-64-efi.yml        |   2 +-
 ci/gitlab-ci-base.yml       |   2 +-
 kas-container               | 562 ++++++++++++++++++++++++++++++++++++
 kas.yml                     |   4 +-
 opt-ci.yml                  |   2 +-
 opt-compat.yml              |   2 +-
 opt-debug.yml               |   2 +-
 opt-linux-4.19.yml          |   2 +-
 opt-linux-4.4.yml           |   2 +-
 opt-linux-5.10.yml          |   2 +-
 opt-linux-5.15.yml          |   2 +-
 opt-linux-5.4.yml           |   2 +-
 opt-linux-6.1.yml           |   2 +-
 opt-linux-latest-4.19.yml   |   2 +-
 opt-linux-latest-4.4.yml    |   2 +-
 opt-linux-latest-5.10.yml   |   2 +-
 opt-linux-latest-5.15.yml   |   2 +-
 opt-linux-latest-5.4.yml    |   2 +-
 opt-linux-latest-6.1.yml    |   2 +-
 opt-linux-latest.yml        |   2 +-
 opt-xenomai-3.0.x.yml       |   2 +-
 opt-xenomai-3.1.x.yml       |   2 +-
 opt-xenomai-3.2.x.yml       |   2 +-
 opt-xenomai-next.yml        |   2 +-
 30 files changed, 594 insertions(+), 38 deletions(-)
 create mode 100755 kas-container

diff --git a/README.md b/README.md
index 638768b..03fcacb 100644
--- a/README.md
+++ b/README.md
@@ -11,18 +11,12 @@ from scratch.
 
 ## Building Target Images
 
-Install `kas-container` from the [kas project](https://github.com/siemens/kas):
-
-    wget https://raw.githubusercontent.com/siemens/kas/3.2.3/kas-container -P ~/bin/
-    chmod a+x ~/bin/kas-container
-
-Furthermore, install docker and make sure you have required permissions to
-start containers.
+Install docker and make sure you have required permissions to start containers.
 
 Next invoke the configuration menu to select the desired image configuration
 and start the build:
 
-    kas-container menu
+    ./kas-container menu
 
 If you built, e.g., a QEMU AMD64 image, this can be run using
 `start-qemu.sh x86`.
@@ -31,7 +25,7 @@ You can also select the desired image configuration on the command line.  To
 build the QEMU AMD64 target with debug options enabled, invoke kas-container
 like this:
 
-    kas-container build kas.yml:board-qemu-amd64.yml:opt-debug.yml
+    ./kas-container build kas.yml:board-qemu-amd64.yml:opt-debug.yml
 
 ### Physical Targets
 
diff --git a/board-beagle-bone-black.yml b/board-beagle-bone-black.yml
index 2da2977..cac4ef4 100644
--- a/board-beagle-bone-black.yml
+++ b/board-beagle-bone-black.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 machine: beagle-bone-black
diff --git a/board-hikey.yml b/board-hikey.yml
index 761782e..390a538 100644
--- a/board-hikey.yml
+++ b/board-hikey.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 machine: hikey
diff --git a/board-qemu-amd64.yml b/board-qemu-amd64.yml
index 100bed8..dab9c88 100644
--- a/board-qemu-amd64.yml
+++ b/board-qemu-amd64.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 machine: qemu-amd64
diff --git a/board-qemu-arm64.yml b/board-qemu-arm64.yml
index 07e142d..b0535fe 100644
--- a/board-qemu-arm64.yml
+++ b/board-qemu-arm64.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 machine: qemu-arm64
diff --git a/board-qemu-armhf.yml b/board-qemu-armhf.yml
index 889dd0d..00942a2 100644
--- a/board-qemu-armhf.yml
+++ b/board-qemu-armhf.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 machine: qemu-armhf
diff --git a/board-x86-64-efi.yml b/board-x86-64-efi.yml
index 225b7f8..f4a33e8 100644
--- a/board-x86-64-efi.yml
+++ b/board-x86-64-efi.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 machine: x86-64-efi
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 2dbb82d..8f36ece 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -23,7 +23,7 @@ variables:
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:3.2.3
+  image: ghcr.io/siemens/kas/kas-isar:4.0
 
 .common-config:
   before_script:
diff --git a/kas-container b/kas-container
new file mode 100755
index 0000000..8fa2d16
--- /dev/null
+++ b/kas-container
@@ -0,0 +1,562 @@
+#!/bin/sh
+#
+# kas - setup tool for bitbake based projects
+#
+# Copyright (c) Siemens AG, 2018-2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a copy
+# of this software and associated documentation files (the "Software"), to deal
+# in the Software without restriction, including without limitation the rights
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# copies of the Software, and to permit persons to whom the Software is
+# furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be
+# included in all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE.
+
+set -e
+
+usage()
+{
+	printf "%b" "Usage: $0 [OPTIONS] { build | shell } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       $0 [OPTIONS] { checkout | dump } [KASOPTIONS] [KASFILE]\n"
+	printf "%b" "       $0 [OPTIONS] for-all-repos [KASOPTIONS] [KASFILE] COMMAND\n"
+	printf "%b" "       $0 [OPTIONS] { clean | cleansstate | cleanall}\n"
+	printf "%b" "       $0 [OPTIONS] menu [KCONFIG]\n"
+	printf "%b" "\nPositional arguments:\n"
+	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
+	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
+	printf "%b" "dump\t\t\tCheck out repositories and write flat version\n"
+	printf "%b" "    \t\t\tof config to stdout.\n"
+	printf "%b" "shell\t\t\tRun a shell in the build environment.\n"
+	printf "%b" "for-all-repos\t\tRun specified command in each repository.\n"
+	printf "%b" "clean\t\t\tClean build artifacts, keep sstate cache and " \
+		    "downloads.\n"
+	printf "%b" "cleansstate\t\tClean build artifacts and sstate cache, " \
+		    "keep downloads.\n"
+	printf "%b" "cleanall\t\tClean build artifacts, sstate cache and " \
+		    "downloads.\n"
+	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
+		    "configured build.\n"
+	printf "%b" "\nOptional arguments:\n"
+	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image.\n"
+	printf "%b" "--with-loop-dev		Pass a loop device to the " \
+		    "container. Only required if\n"
+	printf "%b" "\t\t\tloop-mounting is used by recipes.\n"
+	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
+			"container runtime\n"
+	printf "%b" "\t\t\tfor running the build.\n"
+	printf "%b" "-d\t\t\tPrint debug output (deprecated, use -l debug).\n"
+	printf "%b" "-l, --log-level\t\tSet log level (default=info).\n"
+	printf "%b" "-v\t\t\tSame as -d (deprecated).\n"
+	printf "%b" "--version\t\tprint program version.\n"
+	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
+	printf "%b" "\t\t\tAvoid \$HOME/.ssh unless you fully trust the " \
+		    "container.\n"
+	printf "%b" "--ssh-agent\t\tForward ssh-agent socket to the container.\n"
+	printf "%b" "--aws-dir\t\tDirectory containing AWScli configuration.\n"
+	printf "%b" "--git-credential-store\tFile path to the git credential " \
+		    "store\n"
+	printf "%b" "--no-proxy-from-env\tDo not inherit proxy settings from " \
+		    "environment.\n"
+	printf "%b" "--repo-ro\t\tMount current repository read-only\n" \
+		    "\t\t\t(default for build command)\n"
+	printf "%b" "--repo-rw\t\tMount current repository writeable\n" \
+		    "\t\t\t(default for shell command)\n"
+	printf "%b" "\n"
+	printf "%b" "You can force the use of podman over docker using " \
+		    "KAS_CONTAINER_ENGINE=podman.\n"
+	exit 1
+}
+
+trace()
+{
+	[ -n "${KAS_VERBOSE}" ] && echo "+ $*" >&2
+	"$@"
+}
+
+enable_isar_mode() {
+	if [ -n "${ISAR_MODE}" ]; then
+		return
+	fi
+	ISAR_MODE=1
+
+	KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas-isar"
+	KAS_ISAR_ARGS="--privileged"
+
+	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
+		# sudo is needed for a privileged podman container
+		KAS_CONTAINER_COMMAND="sudo --preserve-env ${KAS_CONTAINER_COMMAND}"
+		# preserved user PATH may lack sbin needed by privileged podman
+		export PATH="${PATH}:/usr/sbin"
+	fi
+}
+
+enable_oe_mode() {
+	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
+		# The container entry point expects that the current userid
+		# calling "podman run" has a 1:1 mapping
+		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --userns=keep-id"
+	fi
+}
+
+run_clean() {
+	if [ -n "${KAS_ISAR_ARGS}" ]; then
+		set_container_image_var
+		# SC2086: Double quote to prevent globbing and word splitting.
+		# shellcheck disable=2086
+		trace ${KAS_CONTAINER_COMMAND} run -v "${KAS_BUILD_DIR}":/build:rw \
+				--workdir=/build --rm ${KAS_ISAR_ARGS} \
+				${KAS_CONTAINER_IMAGE} \
+				sudo rm -rf tmp
+	else
+		trace rm -rf "${KAS_BUILD_DIR}"/tmp*
+	fi
+
+	if [ "$1" != "clean" ]; then
+		SSTATE_DIR=${SSTATE_DIR:-${KAS_BUILD_DIR}/sstate-cache}
+		trace rm -rf "${SSTATE_DIR}"
+
+		if [ "$1" = "cleanall" ]; then
+			DL_DIR=${DL_DIR:-${KAS_BUILD_DIR}/downloads}
+			trace rm -rf "${DL_DIR}"
+		fi
+	fi
+}
+
+KAS_IMAGE_VERSION_DEFAULT="4.0"
+KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
+KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
+
+set_container_image_var() {
+	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
+	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
+	KAS_CONTAINER_IMAGE_PATH="${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_IMAGE_PATH_DEFAULT}}"
+	KAS_CONTAINER_IMAGE_DEFAULT="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
+	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
+}
+
+KAS_WORK_DIR=$(readlink -fv "${KAS_WORK_DIR:-$(pwd)}")
+# KAS_WORK_DIR needs to exist for the subsequent code
+trace mkdir -p "${KAS_WORK_DIR}"
+KAS_BUILD_DIR=$(readlink -fv "${KAS_BUILD_DIR:-${KAS_WORK_DIR}/build}")
+trace mkdir -p "${KAS_BUILD_DIR}"
+
+KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
+if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
+	# Try to auto-detect a container engine
+	if command -v docker >/dev/null; then
+		case $(docker -v 2>/dev/null) in
+		podman*)
+			# The docker command is an alias for podman
+			KAS_CONTAINER_ENGINE=podman
+			;;
+		Docker*)
+			# The docker command is the real docker
+			KAS_CONTAINER_ENGINE=docker
+			;;
+		*)
+			# The docker command is an unknown engine
+			echo "$0: docker command found, but unknown engine detected" >&2
+			exit 1
+		esac
+	elif command -v podman >/dev/null; then
+		KAS_CONTAINER_ENGINE=podman
+	else
+		echo "$0: no container engine found, need docker or podman" >&2
+		exit 1
+	fi
+fi
+
+KAS_RUNTIME_ARGS="--log-driver=none --user=root"
+
+case "${KAS_CONTAINER_ENGINE}" in
+docker)
+	KAS_CONTAINER_COMMAND="docker"
+	;;
+podman)
+	KAS_CONTAINER_COMMAND="podman"
+	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt label=disable"
+	;;
+*)
+	echo "$0: unknown container engine '${KAS_CONTAINER_ENGINE}'" >&2
+	exit 1
+	;;
+esac
+
+# parse kas-container options
+while [ $# -gt 0 ]; do
+	case "$1" in
+	--isar)
+		enable_isar_mode
+		shift 1
+		;;
+	--with-loop-dev)
+		if ! KAS_LOOP_DEV=$(/sbin/losetup -f 2>/dev/null); then
+			if [ "$(id -u)" -eq 0 ]; then
+				echo "Error: loop device not available!"
+				exit 1
+			fi
+			sudo_command="/sbin/losetup -f"
+			sudo_message="[sudo] enter password to setup loop"
+			sudo_message="$sudo_message devices by calling"
+			sudo_message="$sudo_message '$sudo_command': "
+			# SC2086: Double quote to prevent globbing and word splitting.
+			# shellcheck disable=2086
+			if ! KAS_LOOP_DEV=$(sudo -p "$sudo_message" $sudo_command \
+				2>/dev/null); then
+				echo "Error: loop device setup unsuccessful!"
+				echo "try calling '$sudo_command' with root" \
+					"permissions manually."
+				exit 1
+			fi
+		fi
+		KAS_WITH_LOOP_DEV="--device ${KAS_LOOP_DEV}"
+		shift 1
+		;;
+	--runtime-args|--docker-args)
+		[ $# -gt 0 ] || usage
+		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} $2"
+		shift 2
+		;;
+	--ssh-dir)
+		[ $# -gt 2 ] || usage
+		KAS_SSH_DIR="$2"
+		shift 2
+		;;
+	--ssh-agent)
+		KAS_SSH_AUTH_SOCK=$(readlink -fv "$SSH_AUTH_SOCK")
+		shift 1
+		;;
+	--aws-dir)
+		[ $# -gt 2 ] || usage
+		KAS_AWS_DIR="$2"
+		shift 2
+		;;
+	--git-credential-store)
+		[ $# -gt 2 ] || usage
+		KAS_GIT_CREDENTIAL_STORE="$2"
+		shift 2
+		;;
+	--no-proxy-from-env)
+		KAS_NO_PROXY_FROM_ENV=1
+		shift 1
+		;;
+	--repo-ro)
+		KAS_REPO_MOUNT_OPT="ro"
+		shift 1
+		;;
+	--repo-rw)
+		KAS_REPO_MOUNT_OPT="rw"
+		shift 1
+		;;
+	-v | -d)
+		KAS_VERBOSE=1
+		KAS_OPTIONS_DIRECT="${KAS_OPTIONS_DIRECT} -d"
+		shift 1
+		;;
+	-l | --log-level)
+		if [ "$2" = "debug" ]; then
+			KAS_VERBOSE=1
+		fi
+		KAS_OPTIONS_DIRECT="${KAS_OPTIONS_DIRECT} -l $2"
+		shift 2
+		;;
+	--version)
+		echo "$(basename "$0") $KAS_IMAGE_VERSION_DEFAULT"
+		exit 0
+		;;
+	--*)
+		usage
+		;;
+	clean|cleansstate|cleanall)
+		[ $# -eq 1 ] || usage
+		run_clean "$1"
+		exit 0
+		;;
+	shell)
+		KAS_REPO_MOUNT_OPT_DEFAULT="rw"
+		KAS_CMD=$1
+		shift 1
+		break
+		;;
+	build|checkout|for-all-repos|menu)
+		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
+		KAS_CMD=$1
+		shift 1
+		break
+		;;
+	dump)
+		if printf '%s\0' "$@" | grep -xqz -- '--inplace\|-i'; then
+			KAS_REPO_MOUNT_OPT_DEFAULT="rw"
+		else
+			KAS_REPO_MOUNT_OPT_DEFAULT="ro"
+		fi
+		KAS_CMD=$1
+		shift 1
+		break
+		;;
+	*)
+		usage
+		;;
+	esac
+done
+
+[ -n "${KAS_CMD}" ] || usage
+
+KAS_EXTRA_BITBAKE_ARGS=0
+
+# parse kas sub-command options
+while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
+	case "$1" in
+	--skip|--target|--task)
+		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
+		shift 2
+		;;
+	-c|--cmd|--command)
+		KAS_BITBAKE_C_OPTION_ARGS="$2"
+		shift 2
+		;;
+	-E|--preserve-env)
+		echo "$1 is not supported with kas-container"
+		exit 1
+		;;
+	--)
+		KAS_EXTRA_BITBAKE_ARGS=$#
+		;;
+	-*)
+		KAS_OPTIONS="${KAS_OPTIONS} $1"
+		shift 1
+		;;
+	*)
+		KAS_FILES=
+		# SC2086: Double quote to prevent globbing and word splitting.
+		# shellcheck disable=2086
+		for FILE in $(IFS=':'; echo $1); do
+			if ! KAS_REAL_FILE="$(realpath -qe "$FILE")"; then
+				echo "Error: configuration file '${FILE}' not found"
+				exit 1
+			fi
+			if [ -z "${KAS_FILES}" ]; then
+				KAS_FIRST_FILE="${KAS_REAL_FILE}"
+				KAS_FILES="${KAS_REAL_FILE}"
+			else
+				KAS_FILES="${KAS_FILES}:${KAS_REAL_FILE}"
+			fi
+		done
+		shift 1
+		if [ "$KAS_CMD" = "for-all-repos" ]; then
+			KAS_REPO_CMD="$1"
+			shift 1
+		fi
+		;;
+	esac
+done
+
+if [ -n "${KAS_FIRST_FILE}" ]; then
+	KAS_FILE_DIR="$(dirname "${KAS_FIRST_FILE}")"
+	KAS_REPO_DIR=$(git -C "${KAS_FILE_DIR}" rev-parse --show-toplevel 2>/dev/null) \
+		|| KAS_REPO_DIR=$(hg --cwd "${KAS_FILE_DIR}" root 2>/dev/null) \
+		|| KAS_REPO_DIR=${KAS_FILE_DIR}
+else
+	KAS_REPO_DIR=$(pwd)
+fi
+
+SOURCE_DIR_HOST=$(
+	grep -e "^_source_dir_host: " "${KAS_WORK_DIR}/.config.yaml" 2>/dev/null | \
+	sed 's/_source_dir_host:[ ]\+//')
+if [ -n "${SOURCE_DIR_HOST}" ]; then
+	KAS_REPO_DIR="${SOURCE_DIR_HOST}"
+fi
+
+if [ "${KAS_CMD}" = "menu" ]; then
+	if [ -z "${KAS_FIRST_FILE}" ]; then
+		KAS_FIRST_FILE="Kconfig"
+	fi
+
+	# When using the menu plugin, we need to track the KAS_REPO_DIR outside
+	# of the container to later allow a simple `kas-container build`. For
+	# that, we tell the kas menu plugin via an env-var about the location
+	# on the host. This data is then added to the .config.yaml where it can
+	# be evaluated by the next invocation of kas-container.
+
+	if ! [ "$(realpath -qe "${KAS_REPO_DIR}")" = "$(realpath -qe "${KAS_WORK_DIR}")" ]; then
+		set -- "$@" -e _KAS_REPO_DIR_HOST="$(readlink -fv "${KAS_REPO_DIR}")"
+	fi
+
+	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < ${KAS_FIRST_FILE} | \
+		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
+		    -e 's/\f\([[:alpha:]].*\|$\)//' \
+		    -e 's/.*default \"\(.*\)\".*/\1/')
+else
+	if [ -z "${KAS_FIRST_FILE}" ]; then
+		KAS_FIRST_FILE="${KAS_WORK_DIR}/.config.yaml"
+	fi
+
+	BUILD_SYSTEM=$(grep -e "^build_system: " "${KAS_FIRST_FILE}" 2>/dev/null | \
+		sed 's/build_system:[ ]\+//')
+fi
+
+if [ "${BUILD_SYSTEM}" = "isar" ]; then
+	enable_isar_mode
+elif [ -z "${ISAR_MODE}" ]; then
+	enable_oe_mode
+fi
+
+set_container_image_var
+
+KAS_REPO_MOUNT_OPT="${KAS_REPO_MOUNT_OPT:-${KAS_REPO_MOUNT_OPT_DEFAULT}}"
+
+KAS_FILES="$(echo "${KAS_FILES}" | sed 's|'"${KAS_REPO_DIR}"'/|/repo/|g')"
+
+if [ "$(id -u)" -eq 0 ] && [ "${KAS_ALLOW_ROOT}" != "yes" ] ; then
+	echo "Error: Running as root - may break certain recipes."
+	echo "Better give a regular user docker access. Set" \
+	     "KAS_ALLOW_ROOT=yes to override."
+	exit 1
+fi
+
+set -- "$@" -v "${KAS_REPO_DIR}":/repo:${KAS_REPO_MOUNT_OPT} \
+	-v "${KAS_WORK_DIR}":/work:rw -e KAS_WORK_DIR=/work \
+	-v "${KAS_BUILD_DIR}":/build:rw \
+	--workdir=/repo \
+	-e KAS_BUILD_DIR=/build \
+	-e USER_ID="$(id -u)" -e GROUP_ID="$(id -g)" --rm --init
+
+if [ -n "${KAS_SSH_DIR}" ] ; then
+	if [ ! -d "${KAS_SSH_DIR}" ]; then
+		echo "Passed KAS_SSH_DIR '${KAS_SSH_DIR}' is not a directory"
+		exit 1
+	fi
+	set -- "$@" -v "$(readlink -fv "${KAS_SSH_DIR}")":/var/kas/userdata/.ssh:ro
+fi
+
+if [ -n "${KAS_SSH_AUTH_SOCK}" ]; then
+	if [ ! -S "${KAS_SSH_AUTH_SOCK}" ]; then
+		echo "Passed SSH_AUTH_SOCK '${KAS_SSH_AUTH_SOCK}' is not a socket"
+		exit 1
+	fi
+	set -- "$@" -v "${KAS_SSH_AUTH_SOCK}":/ssh-agent/ssh-auth-sock \
+		-e SSH_AUTH_SOCK=/ssh-agent/ssh-auth-sock
+fi
+
+if [ -n "${KAS_AWS_DIR}" ] ; then
+	if [ ! -d "${KAS_AWS_DIR}" ]; then
+		echo "Passed KAS_AWS_DIR '${KAS_AWS_DIR}' is not a directory"
+		exit 1
+	fi
+	set -- "$@" -v "$(readlink -fv "${KAS_AWS_DIR}")":/var/kas/userdata/.aws:ro \
+		-e AWS_CONFIG_FILE="${AWS_CONFIG_FILE:-/var/kas/userdata/.aws/config}" \
+		-e AWS_SHARED_CREDENTIALS_FILE="${AWS_SHARED_CREDENTIALS_FILE:-/var/kas/userdata/.aws/credentials}"
+fi
+
+KAS_GIT_CREDENTIAL_HELPER_DEFAULT=""
+
+if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
+	if [ ! -f "${KAS_GIT_CREDENTIAL_STORE}" ]; then
+		echo "Passed KAS_GIT_CREDENTIAL_STORE '${KAS_GIT_CREDENTIAL_STORE}' is not a file"
+		exit 1
+	fi
+	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="store --file=/var/kas/userdata/.git-credentials"
+	set -- "$@" -v "$(readlink -fv "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
+fi
+
+GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
+
+if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
+	set -- "$@" -e GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER}"
+fi
+
+if [ -f "${NETRC_FILE}" ]; then
+	set -- "$@" -v "$(readlink -fv "${NETRC_FILE}")":/var/kas/userdata/.netrc:ro \
+		-e NETRC_FILE="/var/kas/userdata/.netrc"
+fi
+
+if [ -t 1 ]; then
+	set -- "$@" -t -i
+fi
+
+if [ -n "${DL_DIR}" ]; then
+	trace mkdir -p "${DL_DIR}"
+	set -- "$@" \
+		-v "$(readlink -fv "${DL_DIR}")":/downloads:rw \
+		-e DL_DIR=/downloads
+fi
+
+if [ -n "${SSTATE_DIR}" ]; then
+	trace mkdir -p "${SSTATE_DIR}"
+	set -- "$@" \
+		-v "$(readlink -fv "${SSTATE_DIR}")":/sstate:rw \
+		-e SSTATE_DIR=/sstate
+fi
+
+if [ -n "${KAS_REPO_REF_DIR}" ]; then
+	if [ ! -d "${KAS_REPO_REF_DIR}" ]; then
+		echo "Passed KAS_REPO_REF_DIR '${KAS_REPO_REF_DIR}' is not a directory"
+		exit 1
+	fi
+	set -- "$@" \
+		-v "$(readlink -fv "${KAS_REPO_REF_DIR}")":/repo-ref:rw \
+		-e KAS_REPO_REF_DIR=/repo-ref
+fi
+
+for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK \
+           KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
+           GIT_CREDENTIAL_USEHTTPPATH; do
+	if [ -n "$(eval echo \$${var})" ]; then
+		set -- "$@" -e "${var}=$(eval echo \"\$${var}\")"
+	fi
+done
+
+# propagate only supported SHELL settings
+case "$SHELL" in
+/bin/sh|/bin/bash|/bin/dash)
+	set -- "$@" -e "SHELL=$SHELL"
+	;;
+*)
+	set -- "$@" -e "SHELL=/bin/bash"
+	;;
+esac
+
+if [ -z "${KAS_NO_PROXY_FROM_ENV+x}" ]; then
+	for var in http_proxy https_proxy ftp_proxy no_proxy NO_PROXY; do
+		if [ -n "$(eval echo \$${var})" ]; then
+			set -- "$@" -e "${var}=$(eval echo \$${var})"
+		fi
+	done
+fi
+
+# SC2086: Double quote to prevent globbing and word splitting.
+# shellcheck disable=2086
+set -- "$@" ${KAS_ISAR_ARGS} ${KAS_WITH_LOOP_DEV} ${KAS_RUNTIME_ARGS} \
+    ${KAS_CONTAINER_IMAGE} ${KAS_OPTIONS_DIRECT} ${KAS_CMD} ${KAS_OPTIONS}
+if [ -n "${KAS_BITBAKE_C_OPTION_ARGS}" ]; then
+	set -- "$@" -c "${KAS_BITBAKE_C_OPTION_ARGS}"
+fi
+# SC2086: Double quote to prevent globbing and word splitting.
+# shellcheck disable=2086
+set -- "$@" ${KAS_FILES}
+if [ "$KAS_CMD" = "for-all-repos" ]; then
+	set -- "$@" "${KAS_REPO_CMD}"
+fi
+
+# rotate any extra bitbake args from the front to the end of the argument list
+while [ $KAS_EXTRA_BITBAKE_ARGS -gt 0 ]; do
+	arg="$1"
+	shift 1
+	set -- "$@" "$arg"
+	KAS_EXTRA_BITBAKE_ARGS=$((KAS_EXTRA_BITBAKE_ARGS - 1))
+done
+
+trace ${KAS_CONTAINER_COMMAND} run "$@"
diff --git a/kas.yml b/kas.yml
index 6020c62..26ea415 100644
--- a/kas.yml
+++ b/kas.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 build_system: isar
 
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 4de8b0d5d68ad46829fa1360eabcf3fc8662a39e
+    commit: 4de8b0d5d68ad46829fa1360eabcf3fc8662a39e
     layers:
       meta:
 
diff --git a/opt-ci.yml b/opt-ci.yml
index 80a3970..431b070 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
   includes:
     - opt-debug.yml
 
diff --git a/opt-compat.yml b/opt-compat.yml
index ac120fa..734066a 100644
--- a/opt-compat.yml
+++ b/opt-compat.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   compat: |
diff --git a/opt-debug.yml b/opt-debug.yml
index d967b83..a8399d9 100644
--- a/opt-debug.yml
+++ b/opt-debug.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 # do not apply no debug kernel config fragment
 
diff --git a/opt-linux-4.19.yml b/opt-linux-4.19.yml
index d5fa5ef..960292d 100644
--- a/opt-linux-4.19.yml
+++ b/opt-linux-4.19.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-linux-4.4.yml b/opt-linux-4.4.yml
index 2b9dd14..e455a38 100644
--- a/opt-linux-4.4.yml
+++ b/opt-linux-4.4.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-linux-5.10.yml b/opt-linux-5.10.yml
index ae3b30d..ec9dab3 100644
--- a/opt-linux-5.10.yml
+++ b/opt-linux-5.10.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-linux-5.15.yml b/opt-linux-5.15.yml
index c7447e9..bc0b9d2 100644
--- a/opt-linux-5.15.yml
+++ b/opt-linux-5.15.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-linux-5.4.yml b/opt-linux-5.4.yml
index 2fb586e..1b43394 100644
--- a/opt-linux-5.4.yml
+++ b/opt-linux-5.4.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-linux-6.1.yml b/opt-linux-6.1.yml
index fb0df24..e723454 100644
--- a/opt-linux-6.1.yml
+++ b/opt-linux-6.1.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-linux-latest-4.19.yml b/opt-linux-latest-4.19.yml
index 78f4a43..c1a3040 100644
--- a/opt-linux-latest-4.19.yml
+++ b/opt-linux-latest-4.19.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-latest: |
diff --git a/opt-linux-latest-4.4.yml b/opt-linux-latest-4.4.yml
index 113ba76..d4864b7 100644
--- a/opt-linux-latest-4.4.yml
+++ b/opt-linux-latest-4.4.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-latest: |
diff --git a/opt-linux-latest-5.10.yml b/opt-linux-latest-5.10.yml
index a6bb221..e9ddd7f 100644
--- a/opt-linux-latest-5.10.yml
+++ b/opt-linux-latest-5.10.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-linux-latest-5.15.yml b/opt-linux-latest-5.15.yml
index 02e1a61..288836f 100644
--- a/opt-linux-latest-5.15.yml
+++ b/opt-linux-latest-5.15.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-linux-latest-5.4.yml b/opt-linux-latest-5.4.yml
index d3164e3..2d15e06 100644
--- a/opt-linux-latest-5.4.yml
+++ b/opt-linux-latest-5.4.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-linux-latest-6.1.yml b/opt-linux-latest-6.1.yml
index c5eecd8..3e9ef29 100644
--- a/opt-linux-latest-6.1.yml
+++ b/opt-linux-latest-6.1.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-linux-latest.yml b/opt-linux-latest.yml
index 4f4dd3b..aab2342 100644
--- a/opt-linux-latest.yml
+++ b/opt-linux-latest.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   linux-xenomai-version: |
diff --git a/opt-xenomai-3.0.x.yml b/opt-xenomai-3.0.x.yml
index 4559de8..0962373 100644
--- a/opt-xenomai-3.0.x.yml
+++ b/opt-xenomai-3.0.x.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   xenomai-3-0-x: |
diff --git a/opt-xenomai-3.1.x.yml b/opt-xenomai-3.1.x.yml
index 2479e96..937b5f9 100644
--- a/opt-xenomai-3.1.x.yml
+++ b/opt-xenomai-3.1.x.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   xenomai-3-1-x: |
diff --git a/opt-xenomai-3.2.x.yml b/opt-xenomai-3.2.x.yml
index 1abcef9..401efa2 100644
--- a/opt-xenomai-3.2.x.yml
+++ b/opt-xenomai-3.2.x.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   xenomai-3-2-x: |
diff --git a/opt-xenomai-next.yml b/opt-xenomai-next.yml
index ba0b2da..fd2fbab 100644
--- a/opt-xenomai-next.yml
+++ b/opt-xenomai-next.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 14
 
 local_conf_header:
   xenomai-latest: |
-- 
2.35.3

