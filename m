Message-ID: <4E8ABA5F.6020604@domain.hid>
Date: Tue, 04 Oct 2011 09:48:47 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4E81D866.5000504@domain.hid>
	<CAMesUR40qfwCK0HARML05E+1a3DwaiqZGmEJYY-Nn2pRsc4UyA@mail.gmail.com>
In-Reply-To: <CAMesUR40qfwCK0HARML05E+1a3DwaiqZGmEJYY-Nn2pRsc4UyA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Analogy: idx_write_subd field in a4l_desc_t
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai@xenomai.org

On 01/10/11 00:03, Alexis Berlemont wrote:
>> I'm using xenomai-head on a 2.6.38.8 kernel on x86 with a NI-6251 DAQ
>> board. In this configuration the idx_write_subd field of the a4l_desc_t
>> structure filled by a4l_open() is not set to the proper value but is set
>> to NULL.
>>
>> In previous xanomai/analogy releases this was working properly. Has some
>> initialization code been removed in the latest analogy drivers refactoring?
> 
> Yes. Formerly, on both sides (kernel and user), we used some
> description fields (idx_read_subd and idx_write_subd) so as to quickly
> identify default asynchronous input and output subdevices and to link
> them with buffers (into which, input / output data are copied).

...

> For API / ABI compatibility reasons, I waited a major release before
> removing the fields idx_{read, write}_subd. I should have thought
> twice before removing their initializations. I will fix that soon,
> sorry.

Hello Alexis,

the rational of the change is clear, however having the field in the
structure, but with the wrong value is confusing, especially so because
the documentation does not mention that this field is deprecated and its
value should not be trusted.

I would remove the field altogether, or put back the initialization and
mention the deprecation in the documentation.

> I implemented this change more than one year ago (here is on of the
> many related commits 58ebd5b7efe0cc0ac1e82991d12125ce34dfeee3). That
> was already present in 2.5. Which version were you formerly using?

I thought I was using Xenomai 2.5.6.

Cheers,
-- 
Daniele

