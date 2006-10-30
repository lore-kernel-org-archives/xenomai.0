Message-ID: <4545ECF6.1020209@domain.hid>
Date: Mon, 30 Oct 2006 13:15:50 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mmap and secondary mode
References: <5D63919D95F87E4D9D34FF7748CE2C2A5FF8EC@ARVMAIL1.mra.roland-man.biz>
	<45420754.4040907@domain.hid>
In-Reply-To: <45420754.4040907@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

Jan Kiszka wrote:
> Roderik_Wildenburg@domain.hid wrote:
>> Just to be sure :
>> Does the access of a mmaped address (real_mmamp of a device file e.g.
>> /dev/dualportmemory) force Xenomai to switch to secondary mode ?
>> I would say yes, as the access of the address probably results into a
>> read/write of the device file.
>> Am I right ?
> 
> Depends. If that mapping takes place directly on a physical memory
> region *ahead-of-use*, then you are safe (like with rtdm_iomap_to_user
> from 2.3-devel). But if there is some Linux driver logic in between that
> is triggered via page faults on access to those memory blocks, this is
> certainly indeterministic. Probably easy to find out by analysing the
> Linux driver in question /wrt its mapping code.

But it should be save to call the driver's mmap function in secondary 
mode (init code) and use the virtual address later on in primary mode.

Wolfgang.

