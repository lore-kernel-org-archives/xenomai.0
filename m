Message-ID: <475FC16D.9070004@domain.hid>
Date: Wed, 12 Dec 2007 12:09:33 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <475FBEED.6070900@domain.hid>
	<2ff1a98a0712120259r56d640adxe82764eb63a7c2a@domain.hid>
In-Reply-To: <2ff1a98a0712120259r56d640adxe82764eb63a7c2a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] add missing __real_pthread_kill
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On Dec 12, 2007 11:58 AM, Wolfgang Grandegger <wg@domain.hid> wrote:
>> Hi Gilles,
>>
>> the attached patch adds the missing function __real_pthread_kill to
>> src/skins/posix/wrappers.c.
> 
> This should already been in the trunk. Not yet in v2.4.x though.

  $ svn update
  U    src/skins/posix/wrappers.c
  Updated to revision 3273.

I missed that, sorry for the noise.

Wolfgang.




