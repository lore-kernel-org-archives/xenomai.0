Date: Wed, 12 Oct 2005 08:46:58 -0700
Subject: Re: [Xenomai-help] remove_proc_entry problem semi-tracked down
From: Steven Seeger <steve@domain.hid>
Message-ID: <BF727E02.1806%steve@domain.hid>
In-Reply-To: <434D2396.7080809@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

It doesn't break when all my app does is this. This issue requires more
investigation. Still, nothing I do in userspace should make it kernel panic.
:)

Steven

On 10/12/05 7:54 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

> Steven Seeger wrote:
>> I only seem to get this problem if I start and stop my app a few times
>> without unloading the xenomai modules and reloading them, btw.
>> 
> 
> Ok, this might be a useful hint. Please try crafting a simple test case
> creating 
> a hundred mutexes then destroying them in a row, restarting this app a few
> times 
> without unloading the xeno_native module. It would help to know if it breaks
> too.


