Message-ID: <54F97594.2060605@xenomai.org>
Date: Fri, 06 Mar 2015 10:38:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t3_phHv3kUfCZcwr2bqTys3JPL3iaWACLjP+f1yoD_Nag@mail.gmail.com>
In-Reply-To: <CAKk99t3_phHv3kUfCZcwr2bqTys3JPL3iaWACLjP+f1yoD_Nag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Error boilerplate/wrappers.h no found trying to
 compile RTDM module on 3.x-rc3 cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/06/2015 10:28 AM, Helder Daniel wrote:
> Hi,
> 
> I am trying to compile a simple RTDM driver that rtdm_printks a message
> when IRQ 12 (PS2 mouse) is up.
> 
> It's a Debian 32 bit system on top of a 64 bit core 2 duo P8600 processor,
> however I already installed g++multilib package which get me rid of other
> related errors with missing libc versions.
> 
> I am using a Makefile that works for Xenomai 2.5.x series, but I get an
> error: "boilerplate/wrappers.h: No such file or directory"
> and lot's of other. (Complete list of errors is at the end).
> 
> The make file I am using is this:
> 
> obj-m += intr.o
> 
> EXTRA_CFLAGS := -I/usr/xenomai/include -I/usr/include

This is wrong, you are pulling userland headers. The CFLAGS required to
build a kernel module using the RTDM API should be obtained by:

$(shell xeno-config --kcflags)

-- 
Philippe.

