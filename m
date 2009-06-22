Message-ID: <4A3F368F.90606@domain.hid>
Date: Mon, 22 Jun 2009 09:45:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF023F5611.C8ADBADC-ON652575DD.000E4E0F-652575DD.000F87A0@domain.hid>
In-Reply-To: <OF023F5611.C8ADBADC-ON652575DD.000E4E0F-652575DD.000F87A0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Question on uITRON Skin development and porting
	to iMX27/ARM926EJ-S
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ravikiran Saralaya <ravikiran.saralaya@domain.hid>
Cc: xenomai@xenomai.org

Ravikiran Saralaya wrote:
> 1.      The uITRON specification requires task creation to accept base 
> address of task stack to be allocated. The xnarch_alloc_stack() currently 
> accepts only stack size but not the base address.

The solution is simple: let the system allocate the stack, or implement
the missing functionality.


> I also tried to get different Linux kernel version ported to iMX27, such 
> as 2.6.20, but I don?t have any option here other than 2.6.19 :(

Then I am afraid there is nothing we can do for you. You are on your
own. Sorry.


-- 
					    Gilles.

