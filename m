References: <AE798E990C72C345B223A9C86007D6E8673E6FBC48@CNSHA01078.cn001.siemens.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b722073c-1e38-b182-80e9-85e7ec6075de@xenomai.org>
Date: Sun, 6 Nov 2016 10:08:47 +0100
MIME-Version: 1.0
In-Reply-To: <AE798E990C72C345B223A9C86007D6E8673E6FBC48@CNSHA01078.cn001.siemens.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Freescale's LS2085ardb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "mian.huang@siemens.com" <mian.huang@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/02/2016 07:41 AM, mian.huang@siemens.com wrote:
> Hi:
> 
>         Does the xenomial support the Freescale's LS2085ardb evaluation board?
> 

This is arm64, and Xenomai has only preliminary support for armv8 so far
(Xenomai's -next branch, and ipipe-4.1.y pipeline). Preliminary means
that we have identified issues, and working on fixing them is due.

-- 
Philippe.

