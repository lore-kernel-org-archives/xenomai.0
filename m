From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 26 Nov 2014 12:09:51 -0500
Message-ID: <20141126170951.GG24110@csclub.uwaterloo.ca>
References: <9BA84827B30CBE4996725F98F7DC9123428F6675@SMExchange01.siebmeyer.org>
 <20141126152225.GF24110@csclub.uwaterloo.ca>
 <9BA84827B30CBE4996725F98F7DC9123428F66B5@SMExchange01.siebmeyer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BA84827B30CBE4996725F98F7DC9123428F66B5@SMExchange01.siebmeyer.org>
Subject: Re: [Xenomai] ipipe-arm for kernel 3.12 on ls1021
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 26, 2014 at 04:20:57PM +0000, Hänel-Baas, Alexander wrote:
> Thank you for your really fast reply.
> 
> I have disabled LPAE in the Kernel config, moved the #endif in /arm/mm/fault.c to original position.
> 
> You are right: compiling was now without any errors.
> But the kernel doesn't start.

Well that may just be caused by ipipe not having been ported to that
system yet, or maybe the fact 3.12 was never finished and released.

Of course it is also possible freescal'e kernel doesn't work without LPAE.
Vendors are often very sloppy like that I find.

-- 
Len Sorensen

