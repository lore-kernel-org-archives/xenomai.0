Message-ID: <5176D2FB.8050101@xenomai.org>
Date: Tue, 23 Apr 2013 20:29:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <517536B8.4080508@gmail.com> <51766F9F.6070407@xenomai.org>
	<E3B5BC29-0015-4473-B5F5-304EEAEC8122@gmail.com>
In-Reply-To: <E3B5BC29-0015-4473-B5F5-304EEAEC8122@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to use rtdm_(io/m)map_to_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Victor Hiairrassary <victor.hiairrassary.ml@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/23/2013 02:50 PM, Victor Hiairrassary wrote:

> 
> 
> On 23 avr. 2013, at 13:25, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> 
>> This is wrong. The "abstraction layer" used by an application
>> should be the usual driver interface open/read/write/ioctl and mmap
>> if there are high volumes of data to exchange with the application.
>> Access to the registers should be confined to the driver
>> implementation.
>> 
> 
> The hardware is a FPGA which expose 1024 registers. Currently to read
> or write in a register, we use mmap. How use them with read/write
> file operations of this registers? i.e. in userspace, once mmaped on
> an ptr, we do : ptr[addr] = value. How achieve this with write
> operation, because write accepts only a value ?


The register access is almost certainly the wrong abstraction layer.
If you need writing to registers 2 to 13 starts a motor, then, there
should be an ioctl START_THE_MOTOR, which implementation in RTDM driver
writes to registers 2 to 13. In other words, without knowing what you do
with this FPGA there is no way to answer.

Anyway, if the 1024 registers are 1024 parameters of the FPGA which you
need to configure individually, you can create an ioctl with a structure
where you pass the register number and the value.


-- 
                                                                Gilles.

