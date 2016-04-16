References: <CAP-AUyhPPqU+AzwG8hyVU2nb42_fukCntEFBh9buCjgOk5FWJg@mail.gmail.com>
 <CAP-AUyjnNdUkA5_uHbm_yQvrNR2eF+k9uN-S0CeXBcN601jqKw@mail.gmail.com>
 <CAP-AUygsMMF8gufbaZ==w=sS=UV9EdiQ9hNJzOpUMYt0dsYpCQ@mail.gmail.com>
 <CAP-AUygg+9PdVRi9G1y+YQkc31kwqmjZoW5T4cVmZFHt5Fa5RA@mail.gmail.com>
 <CAP-AUyhBLBo8W6E6sN0urviiHsuZT1aTMXX3MFOy9Vt84y=K_g@mail.gmail.com>
 <CAP-AUyhQvG3PDSzi54kBpn0i2HpULKaSjj7MWxP3deNSjOU73w@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5711D941.30307@xenomai.org>
Date: Sat, 16 Apr 2016 08:18:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAP-AUyhQvG3PDSzi54kBpn0i2HpULKaSjj7MWxP3deNSjOU73w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel ipipe patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Brandon Enochs <enochs.brandon@gmail.com>, xenomai@xenomai.org

On 04/16/2016 12:28 AM, Brandon Enochs wrote:
> Can anyone tell me which distributions are comparible with Xenomai?  It
> seems that the kernel ipipe patch doesn't support any of the LTS
> distributions like RHEL (3.10) or Ubuntu (3.14).

Xenomai can run on any distribution provided the interrupt pipeline is 
available from the kernel. The I-pipe development tracks the mainline 
kernel only, for which we do have support for 3.10 and 3.14 releases.

 From time to time we may track vendor kernels temporarily to provide 
early support for some embedded hardware (ARM SBC/SOM usually), but only 
for a limited time until the vendor code for that target gets merged 
into mainline eventually. We never maintain distro-specific development 
trees though.

If you need to run Xenomai over any distro, you need to adapt the I-pipe 
to your target kernel, or just switch to a mainline kernel for running 
your distro, assuming the platform does not depend on vendor-specific 
drivers.

-- 
Philippe.

