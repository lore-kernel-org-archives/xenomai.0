MIME-Version: 1.0
In-Reply-To: <CADy-PFjCScUGXgUebJj9a6arhZ6mRCnJPuwE3kHT=XcjkY0SpA@mail.gmail.com>
References: <CADy-PFjUiqnyaP5_1T934OLZQPU2NvNZnZj1uEG3MJvzKhgALQ@mail.gmail.com>
	<5069E424.9090500@grandegger.com>
	<CADy-PFjCScUGXgUebJj9a6arhZ6mRCnJPuwE3kHT=XcjkY0SpA@mail.gmail.com>
From: Jonathan Bohren <jonathan.bohren@gmail.com>
Date: Tue, 27 Nov 2012 09:33:09 -0500
Message-ID: <CADy-PFjg9NuOLte1CzoMFs3u+_cPUXE5xu7fzfDOug-qz0sQbg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RTDM and PEAK PCIe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Simon Leonard <simon.v.leonard@gmail.com>, xenomai@xenomai.org

Wolfgang,

I got the PEAK PCAN-003027 card working yesterday, but it required
adding the device ID (0x0003 in addition to 0x0001) to the module
device table `peak_pci_tbl` here:
http://git.xenomai.org/?p=xenomai-2.6.git;a=blob;f=ksrc/drivers/can/sja1000/rtcan_peak_pci.c;h=53c8fef71d6d9e71dce6001941cb5922f6c977d6;hb=HEAD#l79

I've committed my changes to a fork on github under the branch name
"feature_peak_pcie" here:
https://github.com/jbohren-forks/xenomai/compare/feature_peak_pcie

Is this the appropriate channel to make a pull request, or should I do
that somewhere else?

thanks again!
-j

On Mon, Oct 1, 2012 at 3:27 PM, Jonathan Bohren
<jonathan.bohren@gmail.com> wrote:
> On Mon, Oct 1, 2012 at 2:42 PM, Wolfgang Grandegger <wg@grandegger.com>
> wrote:
>>
>> On 10/01/2012 07:27 PM, Jonathan Bohren wrote:
>> > All,
>> >
>> > I'm spec-ing out a new machine for realtime robot control over CANbus
>> > with
>> > Xenomai. We currently use a machine with a PCI-based CANbus card from
>> > PEAK,
>> > but we'd like to upgrade to the PCI Express version with our new
>> > machine.
>> > Specifically the PCAN-PCI Express dual-channel card with galvanic
>> > isolation
>> > (PCAN-003027) <http://www.peak-system.com/PCAN-PCI-Express.206.0.html>.
>> >
>> >>From the looks of it, the current (and older) peak_pci driver in the
>> >
>> > kernel<http://svn.berlios.de/svnroot/repos/socketcan/trunk/kernel/2.6/drivers/net/can/sja1000/peak_pci.c>
>> > lists
>> > the PCIe device, but the peak_pci driver in the Xenomai
>> >
>> > sources<http://git.xenomai.org/?p=xenomai-2.6.git;a=blob;f=ksrc/drivers/can/sja1000/rtcan_peak_pci.c>is
>> > an older version that does not.
>> >
>> > It looks like the PCI card and the PCIe card have the same device ID
>> > (0x0001), but it's not clear if there are any other differences that
>> > would
>> > keep it from working.
>> >
>> > Does anyone know about the Xenomai support for this card?
>>
>> There is support for both of this card in mainline Linux-CAN:
>>
>> http://lxr.linux.no/#linux+v3.6/drivers/net/can/sja1000/peak_pci.c#L64
>>
>> There is no special treatment for the PCIe-version of that card and
>> therefore it should also work with the rtcan_peak_pci driver. But
>> support for 4 channels is still missing.
>
>
> Great, thanks for the quick response!
>
> -j



-- 
Jonathan Bohren
PhD Student
Dynamical Systems and Control Laboratory
Laboratory for Computational Sensing and Robotics
The Johns Hopkins University

(707) 520-4736
jbo@jhu.edu

