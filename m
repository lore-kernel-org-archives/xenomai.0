Message-ID: <50F7F9A9.5020409@xenomai.org>
Date: Thu, 17 Jan 2013 14:16:25 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <50F7DB33.7000902@siemens.com>
In-Reply-To: <50F7DB33.7000902@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] core-3.5 vs. core-3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/17/2013 12:06 PM, Jan Kiszka wrote:
> Hi Philippe,
>
> what's the purpose of having two 3.5 branches and still committing to both?
>

I was still in the process of validating powerpc and blackfin against 
3.5.7 this morning, and I did not want to delay Gilles in releasing 
2.6.2.1 even if based on 3.5.3 for these archs. It turns out that I 
completed this validation a couple of hours ago though. So x86*, arm, 
powerpc* and bfin will have support for kernel 3.5.7 in the upcoming 
2.6.2.1.

-- 
Philippe.

