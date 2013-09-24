Message-ID: <52417BD8.1060509@xenomai.org>
Date: Tue, 24 Sep 2013 13:47:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF396B4F72.527821E8-ONC1257BEC.0054EA5D-C1257BEC.00550203@marposs.com>
	<31e1856136e687804b394e184552f972.squirrel@127.0.0.1>
	<OFC8321BA4.DEA5320E-ONC1257BEC.0055985D-C1257BEC.00567EE5@marposs.com>
	<41178a65d105c2ecba29517766108672.squirrel@127.0.0.1>
	<OF9F68F0D3.ACCF0213-ONC1257BEF.002B87CA-C1257BEF.002CB465@marposs.com>
	<52408833.3020701@xenomai.org>
	<OF7E86F86A.D7514A07-ONC1257BF0.002BDD7A-C1257BF0.002C8E24@marposs.com>
In-Reply-To: <OF7E86F86A.D7514A07-ONC1257BF0.002BDD7A-C1257BF0.002C8E24@marposs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] memory mapped IO and secondary mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: stefano.franzoni@marposs.com
Cc: xenomai@xenomai.org

On 09/24/2013 10:06 AM, stefano.franzoni@marposs.com wrote:
> I tried the function rt_timer_tsc but it does not generate the swap to
> secondary mode.
> It seems that the first write access generates the fault instead the read
> accesses do not generate it.
> I attach a simple example.

Then I am afraid there is nothing to do. Accessing registers in
user-space is not recommended anyway, so we are not going to put
some workarounds for this corner case in the I-pipe patch.

-- 
                                                                Gilles.

