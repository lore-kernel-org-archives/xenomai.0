Message-ID: <bccd05173fa889c14e3017433528c346.squirrel@127.0.0.1>
In-Reply-To: <OF0F116A24.B99EE43E-ONC1257BF0.0040FD1C-C1257BF0.00415BA5@marposs.com>
References: <OF396B4F72.527821E8-ONC1257BEC.0054EA5D-C1257BEC.00550203@marposs.com>
	<31e1856136e687804b394e184552f972.squirrel@127.0.0.1>
	<OFC8321BA4.DEA5320E-ONC1257BEC.0055985D-C1257BEC.00567EE5@marposs.com>
	<41178a65d105c2ecba29517766108672.squirrel@127.0.0.1>
	<OF9F68F0D3.ACCF0213-ONC1257BEF.002B87CA-C1257BEF.002CB465@marposs.com>
	<52408833.3020701@xenomai.org>
	<OF7E86F86A.D7514A07-ONC1257BF0.002BDD7A-C1257BF0.002C8E24@marposs.com>
	<52417BD8.1060509@xenomai.org>
	<OF0F116A24.B99EE43E-ONC1257BF0.0040FD1C-C1257BF0.00415BA5@marposs.com>
Date: Tue, 24 Sep 2013 14:25:36 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
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


stefano.franzoni@marposs.com wrote:
> A good work around for my application is to make a dummy write access to
> memory IO outside reat time thread.
>
> However, I ask if, in a more complex application, the page can be swapped
> and then the transition to secondary mode can happens again.

The page is not swapped out, it does not make any sense to swap out an I/O
page. Other than that I have no idea, you have to check /dev/mem code to
know that.

-- 
                                              Gilles


