References: <d62e1edb-b724-024d-eab7-4f9ed1d152c9@utpvision.it>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3aa5f3f4-2470-1924-4e90-d455d1be6452@xenomai.org>
Date: Tue, 19 Sep 2017 10:59:15 +0200
MIME-Version: 1.0
In-Reply-To: <d62e1edb-b724-024d-eab7-4f9ed1d152c9@utpvision.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problems porting old xeno2 module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Simone Zucchi <simone.zucchi@utpvision.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/19/2017 10:20 AM, Simone Zucchi wrote:
> Hello everybody. I'm trying to port some kernel modules which we used on
> xeno2 to xeno3 cobalt.
> 
> The old code used the native skin so I'm trying to get it working using the
>  transaction kit (trank/native).

The transition kit is for porting user-space apps from the legacy
"native" API of Xenomai 2.x to alchemy. The only API available in kernel
space with Xenomai 3 is RTDM, for drivers.

-- 
Philippe.

