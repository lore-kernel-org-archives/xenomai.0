References: <DB6PR0701MB2456EF1925C87F170E90540EB5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7528e4df-ac06-8893-bf77-7cbf9e91eeef@xenomai.org>
Date: Thu, 5 Apr 2018 08:43:08 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456EF1925C87F170E90540EB5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno-config --no-mode-check still has -lmodechk
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/04/2018 09:58 PM, Giulio Moro wrote:
>  /usr/xenomai/bin/xeno-config --skin cobalt --ldflags --no-mode-check
> 
> returns
> -Wl,--no-as-needed   /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt
> 
> which removes the modechk wrappers, but leaves -lmodechk in. Is this expected?
> 
> As I understand it, libmodechk provides implementations for __wrap_malloc, __wrap_free and __real_malloc, __real_free() are these needed even when the wrappers are disabled, or should -lmodechk not be included?
> 
> 

The main exec may still depend on external libs built with mode checking
wrappers.

-- 
Philippe.

