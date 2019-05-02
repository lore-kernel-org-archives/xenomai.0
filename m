Subject: Re: [Xenomai] called regular poll() rtdm-socket
References: <f4d38a1b-0676-fc70-e42e-c07bc2c98cb0@alaxarxa.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b141fa74-7b0d-33fb-6064-8571dd45ec6f@xenomai.org>
Date: Thu, 2 May 2019 17:01:41 +0200
MIME-Version: 1.0
In-Reply-To: <f4d38a1b-0676-fc70-e42e-c07bc2c98cb0@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 5/2/19 4:07 PM, Leopold Palomo-Avellaneda via Xenomai wrote:
> Hi,
> 
> 
> we developed a C++ library that used rtnet with ethercat. It implements a class
> that interchange information between the RT and NON_RT using xddm. It was
> working but now (using POSIX skin) fails and I several (less than 10) and got
> this message.
> 
> [Xenomai] platformnode[8324] called regular poll() on /dev/rtdm/[rtdm-socket]
> 
> Could you explain me what is it? because I have searched on web and what I found
> I didn't understand well.

Some code invoked some POSIX I/O routines from the glibc with a file
descriptor obtained from RTDM. e.g.

fd = __RT(socket(...));
__STD(write(fd, ...));

-- 
Philippe.

