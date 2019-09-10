Subject: Re: [xenomai-images][PATCH v2 9/9] tests/README: Add Architecture
References: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
 <20190910144459.13239-10-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c8ba5d9c-04d7-6cb8-4e67-1c132e196b61@siemens.com>
Date: Tue, 10 Sep 2019 18:54:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190910144459.13239-10-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 10.09.19 16:44, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add the schematic architecture of the current tests setup.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   tests/README.md | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/tests/README.md b/tests/README.md
> index ffe7ba2..6ee8ada 100644
> --- a/tests/README.md
> +++ b/tests/README.md
> @@ -35,8 +35,53 @@ and check machine data from the target.
>   
>   The xenomai test suite executes the xeno-test tool from xenomai/testsuite.
>   
> +# Test Architecture
> +
> +To test xenomai-images on the target hardware the following architecture
> +is used:
> +```
> +                                                               +----------+
> +                                                               | Target 1 |
> +                                                            /--|  beagle  |
> ++-----------+        +---------+       +---------+    /-----   |  bone    |
> +|           |        | LAVA    |       | LAVA    | ---         +----------+
> +| gitlab-   | ------ | master  |------ | Dis-    | --
> +| runner    |        |         |       | patcher | \ \---      +----------+
> ++-----------+        +---------+       +---------+  \-   \---  | Target 2 |
> +                                                      \      \-| x86-64   |
> +                                                       \       |          |
> +                                                        \-     +----------+
> +                                                          \
> +                                                           \   +----------+
> +                                                            \- | Target n |
> +                                                              \| qemu     |
> +                                                               |          |
> +                                                               +----------+
> +```
> +A test is deployed in the following steps:
> +1. gitlab-runner: builds the artifacts
> +2. After the build is successful the build artifacts are deployed to the
> +   Lava master per scp.
> +3. The runner sends a lava job description to the LAVA master, who triggers the
> +job execution on LAVA Dispatcher.
> +
> +The LAVA master selects the LAVA Dispatcher to execute the given job on a
> +target. Qemu targets are executed directly on the LAVA Dispatcher. For non-virtual
> +targets the payload (kernel,rootfs,...) is deployed via tftp to the selected
> +hardware.
> +
> +The dispatcher executes the following steps:
> +1. Instrumentation of the rootfs. This will collect the necessary lavatools
> +and adds them to the rootfs
> +2. Power up the target
> +3. deploy the payload(kernel,rootfs,...) with help of the bootloader
> +4. trigger the payload boot
> +5. execute the tests
> +6. power off the target
> +
>   # LAVA Setup
>   
>   Setup a lava environment by following the
>   [installation guide](https://docs.lavasoftware.org/lava/first-installation.html)
>   or use [lava-docker](https://github.com/kernelci/lava-docker).
> +
> 

Thanks, all merged into next (except for this whitespace change here that caused 
git to warn).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

