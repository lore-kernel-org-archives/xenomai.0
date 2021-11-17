Subject: Re: [xenomai-images][PATCH v3 0/8] Update to Debian 11
References: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f42abf2d-b83d-2d83-102f-258daac5337b@siemens.com>
Date: Wed, 17 Nov 2021 19:10:12 +0100
MIME-Version: 1.0
In-Reply-To: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 15.11.21 11:13, Florian Bezdeka wrote:
> Hi all,
> 
> with this series the Xenomai demo image will be based on Debian 11.
> 
> All Debian 11 related topics that had to be adressed are now merged to
> all Xenomai branches, stable branches included. CI runs were successfully
> tested against all branches.
> 
> Patch 7 made it to the list but has not been applied to next yet. That's
> why I resend it, integrated into this series at the right place.
> 
> The Xenomai LAVA instance has been down while working on this topic. The
> job submission to LAVA failed, but the test jobs where still marked as
> successful. That is now fixed as well.
> 
> Best regards,
> Florian
> 
> Changes since v2:
>  - Updated ISAR to latest version, allows removal of downstream patches
>  - Adjust CI scripts related to ISAR upstream changes
>  - Patches reordered (removed ISAR patches)
>  - Moved all CI related kas configs to opt-ci.yml
> 
> Changes since v1:
>  - Renamed opt-lava-test.yml to opt-ci-board.yml
>  - Moved removal of expand-on-first-boot from opt-ci.yml to opt-ci-board.yml
> 
> Florian Bezdeka (7):
>   ci/kas: Consolidate kas option files, introduce opt-ci.yml
>   ci/kas: Integrate opt-debug.yml into opt-ci.yml
>   ci/kas: Disable partition expanding during first boot
>   isar: Update ISAR to current next
>   ci/kas: Skip ssh key regeneration for all ci targets
>   ci: Fail test job when an error occurred during lava job submission
>   xenomai-demo: Switch to Debian bullseye
> 
> Jan Kiszka (1):
>   linux-xenomai: arm: Enable CONFIG_ARM_MODULE_PLTS
> 
>  ci/gitlab-ci-base.yml                      | 10 ++-----
>  conf/distro/xenomai-demo.conf              |  4 +--
>  conf/machine/beagle-bone-black.conf        |  2 +-
>  conf/machine/hikey.conf                    |  2 +-
>  kas.yml                                    |  2 +-
>  opt-ci.yml                                 | 34 ++++++++++++++++++++++
>  opt-ext4-gz.yml                            | 24 ---------------
>  opt-lava-test.yml                          | 20 -------------
>  recipes-kernel/linux/files/armhf_defconfig |  1 -
>  scripts/deploy_to_aws.sh                   | 11 ++++++-
>  scripts/run-lava-tests.sh                  |  1 +
>  start-qemu.sh                              |  5 +++-
>  tests/jobs/xenomai-hikey.yml               |  2 +-
>  tests/jobs/xenomai-qemu-arm64.yml          |  2 +-
>  14 files changed, 58 insertions(+), 62 deletions(-)
>  create mode 100644 opt-ci.yml
>  delete mode 100644 opt-ext4-gz.yml
>  delete mode 100644 opt-lava-test.yml
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

