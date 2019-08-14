MIME-Version: 1.0
In-Reply-To: <CAPm8-H5L2uqzU6G+DLB8YLKR7wy01iFEmzKWuu6cjRHkz3CCgw@mail.gmail.com>
References: <mailman.23.1565782715.963.xenomai@xenomai.org>
 <f84d0694-1e97-51cb-dd10-2ba601e2626e@siemens.com>
 <CAPm8-H5L2uqzU6G+DLB8YLKR7wy01iFEmzKWuu6cjRHkz3CCgw@mail.gmail.com>
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Wed, 14 Aug 2019 20:47:17 +0300
Message-ID: <CAPm8-H45X6vmrTLdN0-AQ9dDHqKmXA8Q+P6RWhTn4+DBP2Lrhw@mail.gmail.com>
Subject: Fwd: Xenomai - RTNet - patch error
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

---------- Forwarded message ----------
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Wed, 14 Aug 2019 20:46:19 +0300
Subject: Re: Xenomai - RTNet - patch error
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Hello Quirin,

  Thank you for this quick answer.

On 8/14/19, Quirin Gylstorff <quirin.gylstorff@siemens.com> wrote:
> Hi Laurentiu,
>
>> Hello xenomai community,
>>
>>    I am an open source enthusiast interested in Xenomai and RTNet.
>> I have the RTNet modules successfully installed on BeagleBone black
>> and now I want to install RTNet on qemu-system-x86_64
>> in order to do more tests with bbb and x86_64.
>>
> We are also interested using the beagle bone black as the target device
> for xenomai. Do you want to supply us the patches for it?

Here are some hints, I just wanted to have something that works:
- tested on 4.14.108 robertcnelson kernel sources,
https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-xenomai-4.14.y
- https://github.com/G-Ray/xenomai-boneblack-rtnet-drivers
those drivers were adapted after Hidde (see RTNet mailing list on
sourceforge and search for beaglebone), written and tested on linux
4.1

quick and dirty fixes in order to run on 4.14.108 (success with
rtping, more tests will follow)
- rt_ticpsw must be inserted after rt_smsc and rt_davinci_mdio and
before rtnet start
- drivers/xenomai/net/drivers/ticpsw/cpsw.c
	if (of_property_read_u32(node, "rx_descs", &prop)) {
		dev_err(&pdev->dev, "Missing rx_descs property in the DT; default to 64\n");
		prop = 64;
		//return -EINVAL;
	}
- rt_davinci_mdio.c, davinci_mdio_probe()
    ...
    /* scan and dump the bus */
    for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
        phy = mdiobus_get_phy(data->bus, addr);
        if (phy) {
            dev_info(dev, "phy[%d]: device %s, driver %s\n",
                 phy->mdio.addr, phydev_name(phy),
                 phy->drv ? phy->drv->name : "unknown");
        }
    }
    return 0;
}
- in kernel
drivers/net/phy/phy_device.c
int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
              u32 flags, phy_interface_t interface)
{
//struct module *ndev_owner = dev->dev.parent->driver->owner;
// comment all lines that use ndev_owner

>
>
>>    I have tried to compile the project
>> https://github.com/jan-kiszka/xenomai-images
>> with the command
>> kas-docker --isar build kas.yml:board-qemu-amd64.yml
>
>
> The github repository from Jan is outdated an no longer
> maintained/updated. Use https://gitlab.denx.de/Xenomai/xenomai-images
> instead.
>
> How did you get to the github repository?
I found it on google.

>
>> and it returns the below copied error. > Do you have any ideas how to get
>> over it? Maybe to transform it into
> an warning,
>> or by automatically/manually answer <yes> to patch anyway.
>>
>> ERROR: xenomai-9999-next-r0 do_patch: patching failed
>> ERROR: xenomai-9999-next-r0 do_patch: Function failed: do_patch
>> ERROR: Logfile of failure stored in:
>> /work/build/tmp/work/xenomai-demo-amd64/xenomai-9999-next-r0/temp/log.do_patch.123
>> ERROR: Task (/repo/recipes-xenomai/xenomai/xenomai_next.bb:do_patch)
>> failed with exit code '1'
>> NOTE: Tasks Summary: Attempted 46 tasks of which 45 didn't need to be
>> rerun and 1 failed.
>>
>> Summary: 1 task failed:
>>    /repo/recipes-xenomai/xenomai/xenomai_next.bb:do_patch
>> Summary: There were 2 ERROR messages shown, returning a non-zero exit
>> code.
>>
>> $ cat
>> build/tmp/work/xenomai-demo-amd64/xenomai-9999-next-r0/temp/log.do_patch
>> DEBUG: Executing python function do_patch
>> DEBUG: Fetcher accessed the network with the command git -c
>> core.fsyncobjectfiles=0 ls-remote
>> https://gitlab.denx.de/Xenomai/xenomai.git
>> DEBUG: Running export PSEUDO_DISABLED=1; export
>> GIT_PROXY_COMMAND="oe-git-proxy"; export NO_PROXY="*"; export
>> PATH="/work/isar/bitbake/bin:/work/isar/scripts:/usr/sbin:/usr/bin:/sbin:/bin";
>> export HOME="/tmp/tmp89g2x4r8"; git -c core.fsyncobjectfiles=0
>> ls-remotehttps://gitlab.denx.de/Xenomai/xenomai.git
>> NOTE: patch --no-backup-if-mismatch -p 1 --directory
>> /work/build/tmp/work/xenomai-demo-amd64/xenomai-9999-next-r0/git
>> --input
>> /work/build/tmp/work/xenomai-demo-amd64/xenomai-9999-next-r0/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch
>> patching file debian/rules
>>
>> Reversed (or previously applied) patch detected!  Assume -R? [n]
>> Apply anyway? [n]
>> Skipping patch.
>> 1 out of 1 hunk ignored -- saving rejects to file debian/rules.rej
>> ERROR: patching failed
>> DEBUG: Python function do_patch finished
>> ERROR: Function failed: do_patch
>>
> ISAR tries to apply the patch on the current HEAD of next, but the patch
> is already submitted patch and therefore git fails to apply the patch.
>
>>
>> Thank you and kind regards,
>> L-C. Duca
>
>
> Can we clarify for you that
> https://gitlab.denx.de/Xenomai/xenomai-images is the correct image. Like
> linking it to Xenomai Main page or mention it the in the README?
>
> Kind regards,
> Quirin
>

Kind regads,
L-C

