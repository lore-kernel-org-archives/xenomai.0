Subject: Re: Xenomai - RTNet - patch error
References: <f84d0694-1e97-51cb-dd10-2ba601e2626e@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Message-ID: <d8e82c41-1813-c4f8-74b8-ff5ec75c84d2@siemens.com>
Date: Wed, 14 Aug 2019 17:06:13 +0200
MIME-Version: 1.0
In-Reply-To: <f84d0694-1e97-51cb-dd10-2ba601e2626e@siemens.com>
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
To: xenomai@xenomai.org


Hi,

> Hello xenomai community,
> 
>    I am an open source enthusiast interested in Xenomai and RTNet.
> I have the RTNet modules successfully installed on BeagleBone black
> and now I want to install RTNet on qemu-system-x86_64
> in order to do more tests with bbb and x86_64.
> 
We are also interested using the beagle bone black as the target device 
for xenomai. Do you want to supply us the patches for it?


>    I have tried to compile the project
> https://github.com/jan-kiszka/xenomai-images
> with the command
> kas-docker --isar build kas.yml:board-qemu-amd64.yml


The github repository from Jan is outdated an no longer 
maintained/updated. Use https://gitlab.denx.de/Xenomai/xenomai-images 
instead.

How did you get to the github repository?

> and it returns the below copied error. > Do you have any ideas how to get over it? Maybe to transform it into 
an warning,
> or by automatically/manually answer <yes> to patch anyway.
> 
> ERROR: xenomai-9999-next-r0 do_patch: patching failed
> ERROR: xenomai-9999-next-r0 do_patch: Function failed: do_patch
> ERROR: Logfile of failure stored in:
> /work/build/tmp/work/xenomai-demo-amd64/xenomai-9999-next-r0/temp/log.do_patch.123
> ERROR: Task (/repo/recipes-xenomai/xenomai/xenomai_next.bb:do_patch)
> failed with exit code '1'
> NOTE: Tasks Summary: Attempted 46 tasks of which 45 didn't need to be
> rerun and 1 failed.
> 
> Summary: 1 task failed:
>    /repo/recipes-xenomai/xenomai/xenomai_next.bb:do_patch
> Summary: There were 2 ERROR messages shown, returning a non-zero exit code.
> 
> $ cat build/tmp/work/xenomai-demo-amd64/xenomai-9999-next-r0/temp/log.do_patch
> DEBUG: Executing python function do_patch
> DEBUG: Fetcher accessed the network with the command git -c
> core.fsyncobjectfiles=0 ls-remote
> https://gitlab.denx.de/Xenomai/xenomai.git
> DEBUG: Running export PSEUDO_DISABLED=1; export
> GIT_PROXY_COMMAND="oe-git-proxy"; export NO_PROXY="*"; export
> PATH="/work/isar/bitbake/bin:/work/isar/scripts:/usr/sbin:/usr/bin:/sbin:/bin";
> export HOME="/tmp/tmp89g2x4r8"; git -c core.fsyncobjectfiles=0
> ls-remotehttps://gitlab.denx.de/Xenomai/xenomai.git
> NOTE: patch --no-backup-if-mismatch -p 1 --directory
> /work/build/tmp/work/xenomai-demo-amd64/xenomai-9999-next-r0/git
> --input /work/build/tmp/work/xenomai-demo-amd64/xenomai-9999-next-r0/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch
> patching file debian/rules
> 
> Reversed (or previously applied) patch detected!  Assume -R? [n]
> Apply anyway? [n]
> Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file debian/rules.rej
> ERROR: patching failed
> DEBUG: Python function do_patch finished
> ERROR: Function failed: do_patch
> 
ISAR tries to apply the patch on the current HEAD of next, but the patch 
is already submitted patch and therefore git fails to apply the patch.

> 
> Thank you and kind regards,
> L-C. Duca


Can we clarify for you that 
https://gitlab.denx.de/Xenomai/xenomai-images is the correct image. Like 
linking it to Xenomai Main page or mention it the in the README?

Kind regards,
Quirin

