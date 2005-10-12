Message-ID: <434D2396.7080809@domain.hid>
Date: Wed, 12 Oct 2005 16:54:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] remove_proc_entry problem semi-tracked down
References: <BF727066.17FD%steve@domain.hid>
In-Reply-To: <BF727066.17FD%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Steven Seeger <steve@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I only seem to get this problem if I start and stop my app a few times
> without unloading the xenomai modules and reloading them, btw.
> 

Ok, this might be a useful hint. Please try crafting a simple test case creating 
a hundred mutexes then destroying them in a row, restarting this app a few times 
without unloading the xeno_native module. It would help to know if it breaks too.

-- 

Philippe.

