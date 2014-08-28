Message-ID: <53FF908C.5070503@xenomai.org>
Date: Thu, 28 Aug 2014 22:26:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdteuWLz2YAhnsQZo9wH7T6o5F62du7MdZ+fZg6+A+JqBZQ@mail.gmail.com>
In-Reply-To: <CAKKWdteuWLz2YAhnsQZo9wH7T6o5F62du7MdZ+fZg6+A+JqBZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a question about domains
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>, xenomai <xenomai@xenomai.org>

On 08/09/2014 04:45 PM, ali hagigat wrote:
> I wonder if anybody can answer this and i apprecite in advance.
> Nothing can change the current domain! as far as i looked in the code.
> How is that possible?
> does xnpod_schedule() can set a new current domain for a CPU?
> It seems that current domian is set to "root" and keeps that forever.
> Only some functions temporarily change "current domain" to "head" but
> immediately it returns to "root" or "current domain".

To anyone wondering about this interpretation: it does not make sense.
For an explanation of the Adeos domain concept, see:

http://xenomai.org/2014/06/life-with-adeos/
http://www.opersys.com/ftp/pub/Adeos/adeos.pdf

-- 
                                                                Gilles.

