Message-ID: <4E8756EA.1060700@domain.hid>
Date: Sat, 01 Oct 2011 20:07:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E81D866.5000504@domain.hid>
	<CAMesUR40qfwCK0HARML05E+1a3DwaiqZGmEJYY-Nn2pRsc4UyA@mail.gmail.com>
In-Reply-To: <CAMesUR40qfwCK0HARML05E+1a3DwaiqZGmEJYY-Nn2pRsc4UyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 10/01/2011 12:03 AM, Alexis Berlemont wrote:
> Hi,
> 
> On Tue, Sep 27, 2011 at 4:06 PM, Daniele Nicolodi <daniele@domain.hid> wrote:
>> Hello,
>>
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
> 
> Most of the time, there were only one asynchronous read / write
> subdevice per card; so, the original Comedi way was ok.
> 
> Unfortunately, some boards now display many asynchronous subdevices of
> the same type. To tackle this issue, I could have implemented the
> workaround proposed by Comedi (give the possibility to attach the
> driver a second time and select the proper subdevice). I tried
> something else: when the driver is opened an asynchronous buffer is
> instanciated; at init time, this buffer does not belong to any
> subdevice but when an asynchronous command is sent, the buffer is
> temporarily reserved by the targeted subdevice.
> 
> Thus instead of re-attaching drivers with devices, the developer gets
> direct access on any subdevice; if he needs to perform two
> simultaneous asyncrhonous acquisitions on the same card, he just has
> to open the analogy device twice (a4l_open).
> 
> For API / ABI compatibility reasons, I waited a major release before
> removing the fields idx_{read, write}_subd. I should have thought
> twice before removing their initializations. I will fix that soon,
> sorry.

2.6 is a new major release, and not out yet, so, if you want to remove
something, it is still time.

-- 
                                                                Gilles.

