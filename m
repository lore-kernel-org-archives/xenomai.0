Message-ID: <4E8AEB66.9030500@domain.hid>
Date: Tue, 04 Oct 2011 13:17:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E81D866.5000504@domain.hid>
	<CAMesUR40qfwCK0HARML05E+1a3DwaiqZGmEJYY-Nn2pRsc4UyA@mail.gmail.com>
	<4E8756EA.1060700@domain.hid> <4E8ABC9A.4070604@domain.hid>
In-Reply-To: <4E8ABC9A.4070604@domain.hid>
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
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

On 10/04/2011 09:58 AM, Daniele Nicolodi wrote:
> On 01/10/11 20:07, Gilles Chanteperdrix wrote:
>>> For API / ABI compatibility reasons, I waited a major release before
>>> removing the fields idx_{read, write}_subd. I should have thought
>>> twice before removing their initializations. I will fix that soon,
>>> sorry.
>>
>> 2.6 is a new major release, and not out yet, so, if you want to remove
>> something, it is still time.
> 
> If we are open to some partially backward incompatible changes I propose
> to also change the meaning of the a4l_desc_t board_name field, to really
> be the board name, instead of the driver name. I find this information
> more useful when enumerating devices in my setup.
> 
> I would also like to propose a patch to demote some messages, logged at
> each interrupt, in the ni_pcimio driver from the info to the debug
> level. I run continuous acquisitions and those kernel messages pollute
> my syslog with not much added value and fill my disc with redundant
> information.

If you want things merged, send the patches, they will reach
xenomai-head repository through Alex.

-- 
                                                                Gilles.

