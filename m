Message-ID: <4CB5BFBF.6030608@domain.hid>
Date: Wed, 13 Oct 2010 16:18:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DF9F3A3C150B0646A17FF1487C1B6D5E0380C00C@rennsmail06.eu.thmulti.com>	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C00E@rennsmail06.eu.thmulti.com>	<4CB57DB2.3010709@domain.hid>	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C010@domain.hid>	<4CB5A7DD.9090203@domain.hid>	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C011@domain.hid>
	<4CB5BD16.3080102@domain.hid>
In-Reply-To: <4CB5BD16.3080102@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_heap and DMA32 zone
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Daniel Jacques (Alten)" <jacques.daniel@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Daniel Jacques (Alten) wrote:
>> Yes, it seems to be the solution.
>> I performed the following patch and the problem is solved on my application
>>
>> (...)
>> This patch or similar could be included in a next release.
>> Thanks for your help Gilles,
> 
> If you generate it with git-format-patch/git-send-mail, you can even get
> your name in the logs :-)

Ok, forget it, the patch is simple enough. But please next time, use
diff -p option, it allows us to apply the changes manually if patch fails.

-- 
					    Gilles.

