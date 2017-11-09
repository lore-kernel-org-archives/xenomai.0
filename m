References: <af0af43e-41b6-dd87-2d1b-d8564d34801b@alaxarxa.net>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <edf749e7-bd1f-6e67-7dd6-7089f27b68c3@alaxarxa.net>
Date: Thu, 9 Nov 2017 09:46:02 +0100
MIME-Version: 1.0
In-Reply-To: <af0af43e-41b6-dd87-2d1b-d8564d34801b@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai cannot be built in Debian Stretch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 08/11/17 16:12, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> 
> I'm trying to build Xenomai 3.0.5 in a Debian Stretch/Buster Amd64 env.
> I'm getting this error:
> 
> /usr/bin/ld: -r and -pie may not be used together
> 
> 
> It's because the default -pie in gcc. I have tried to investigate, but I
> have not found the "-r". probably because the wrap-link script.
> 
> Please, could you give me some idea how to solve it?

I'm answer myself. It seems that yesterday I was obfuscated. Just

export CFLAGS="$CFLAGS -no-pie"

solved the problem.

Best regards,

Leopold

-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

