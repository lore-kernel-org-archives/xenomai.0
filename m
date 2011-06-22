Message-ID: <4E022DB9.5020508@domain.hid>
Date: Wed, 22 Jun 2011 20:00:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=qe3CqD9U_T3nF6xBN+nZNbxF7Gg@domain.hid>		<4E00A476.2080006@domain.hid>
	<4E01977E.1080202@domain.hid>		<4E01AB2C.4070409@domain.hid>
	<1308733051.2159.12.camel@domain.hid>		<4E02162A.9060004@domain.hid>
	<1308760138.2159.92.camel@domain.hid> <4E022C64.3040805@domain.hid>
In-Reply-To: <4E022C64.3040805@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_dev_ioctl
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: David Wiebe <dwiebe2@domain.hid>
Cc: xenomai@xenomai.org

On 06/22/2011 07:54 PM, David Wiebe wrote:
> On 11-06-22 09:28 AM, Philippe Gerum wrote:
>> On Wed, 2011-06-22 at 09:19 -0700, David Wiebe wrote:
>>> On 11-06-22 01:57 AM, Philippe Gerum wrote:
>>> Still not compiling.
>>>
>> Your build flags are likely wrong. Did you get them via xeno-config?
> 
> Here are my build flags.
> 
> CFLAGS=`DESTDIR=/home/david/sdir 
> /home/david/sdir/usr/xenomai/bin/xenomai-config --skin native --cflags`
> 
> LDFLAGS=`DESTDIR=/home/david/sdir 
> /home/david/sdir/usr/xenomai/bin/xenomai-config --skin native --ldflags`

You need to obtain flags for rtdm with xeno-config --skin rtdm etc...

-- 
                                                                Gilles.

