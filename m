References: <BN3PR1101MB10425C38098D5CD44E2EDDB2B0100@BN3PR1101MB1042.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <635d7cf3-a695-9225-9f7d-070bda57008f@xenomai.org>
Date: Fri, 26 Jan 2018 16:22:11 +0100
MIME-Version: 1.0
In-Reply-To: <BN3PR1101MB10425C38098D5CD44E2EDDB2B0100@BN3PR1101MB1042.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Stack Overflow when changing Affinity
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henry Bausley <hbausley@deltatau.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/09/2018 11:35 PM, Henry Bausley wrote:
> We have an application that gets run repeatedly that causes a stack overflow.  The source is at the end of this mail.
> We have tracked it down to changing the affinity.
> 
> We have used xenomai 2.6.5 and 2.6.4 and kernels 3.14.28 and 4.1.18 and seen identical results.  Our platform is an LS1021A NXP/Freescale ARM processor.  Is this a bug or are we incorrectly using affinity
> 
> 

Most likely a Xenomai bug, the issue does not even happen when changing
the affinity, but when binding a new process to the real-time core. I'd
say that such core is doing something wrong after noticing the affinity
change, which corrupts the kernel state/memory in some obscure ways.

-- 
Philippe.

