References: <20160114183423.69665622@md1em3qc> <5698AEA6.6030906@xenomai.org>
 <20160202184310.505cf6be@md1em3qc> <56B217CD.9020805@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56B22150.9050003@xenomai.org>
Date: Wed, 3 Feb 2016 16:48:32 +0100
MIME-Version: 1.0
In-Reply-To: <56B217CD.9020805@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe x86_64 huge page ioremap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai@xenomai.org

On 02/03/2016 04:07 PM, Philippe Gerum wrote:
Some ARM families such
> as imx6 look ok too these days, hence the recent dropping of pte pinning

To be precise, the criterion is rather the CPU architecture, v6k and v7
are fine with direct handling of minor faults on trap entry.

-- 
Philippe.

