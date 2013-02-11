Message-ID: <5118A019.6080805@xenomai.org>
Date: Mon, 11 Feb 2013 08:39:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <718DFA7882181D45B8BD18F31C46D55427A675D6@MBX204.domain.local>
In-Reply-To: <718DFA7882181D45B8BD18F31C46D55427A675D6@MBX204.domain.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai exec wrapper for userland binaries?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Perry <Gregory.Perry@govirtual.tv>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/11/2013 06:35 AM, Gregory Perry wrote:

> Is there a Xenomai equivalent to say for example 'exec' that can
> execute a traditional userland binary with hard realtime scheduling?
> Or do all applications have to be rewritten to leverage the Xenomai
> API/skins?


The latter. For the posix skin, you can use the following document:
http://xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai

-- 
                                                                Gilles.

