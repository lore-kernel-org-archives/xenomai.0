References: <83a11fe5-fa49-7337-6b07-00715cd4837a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d3b98501-7333-354c-d144-fed2547e6e39@xenomai.org>
Date: Thu, 1 Feb 2018 19:18:16 +0100
MIME-Version: 1.0
In-Reply-To: <83a11fe5-fa49-7337-6b07-00715cd4837a@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] libs: Mode-switching notice/debug/warning/panic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 02/01/2018 05:43 PM, Jan Kiszka wrote:
> Hi,
> 
> it seems those functions above force the caller always to secondary mode
> (ok, panic is not an issue). Intentionally? To avoid using the wrapped
> versions which may trigger one of the calls again? Or could we also call
> the RT versions, at least after init_done?
> 

If you refer to __printout() in libboilerplate, I believe so, since all
the preceding code assumes the process is already bound to the rt system
anyway, which is required to init the printf support. Synchronizing with
the printer loop before leaving would be a must though - maybe directly
into __panic() for that purpose.

-- 
Philippe.

