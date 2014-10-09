Date: Thu, 9 Oct 2014 03:14:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141009011443.GD30368@sisyphus.hd.free.fr>
References: <CANgF67QfJfNi+NwHKvibymddbGhjqPZb6Gxjag4myQGskJe_0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgF67QfJfNi+NwHKvibymddbGhjqPZb6Gxjag4myQGskJe_0A@mail.gmail.com>
Subject: Re: [Xenomai] undefined reference to `rt_printf'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: agnes jurek <agnessjurek@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Oct 09, 2014 at 01:08:05AM +0300, agnes jurek wrote:
> I tried to execute a rxenomai tdm example
> <http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html>. There are
> all step for compilinig this code.
>
> But when I run "xeno-config --xeno-cflags" and "xeno-config --xeno-ldflags"
> , it said that   "--xeno-cflags is deprecated, use --skin=name
> --cflags".

This should be a strong hint that these examples, which by the way,
you can see are not on Xenomai server, so completely escape the
control of the Xenomai project, are made for earlier releases of
Xenomai.

So
> I used "xeno-config  --skin=native --cflags" and "eno-config  --skin=native
> --ldflags".
>
>
>  But When I run gcc $CFLAGS $LDFLAGS  -lnative -lrtdk  ex01.c -o ex01  , I
> got error message "undefined reference to `rt_task_create'"

For the -lrtdk, see the answer to your previous mail. For the
question about gcc command line, such basic questions about using
gcc is completely out of topic on this mailing list. We assume
people who come on this list have a working knowledge of gcc and are
able to compile programs with additional libraries. If you have not
this working knowledge, I suggest you try and acquire it somewhere
else than on this list.

If you were someone different, I would point you to gcc
documentation here:
https://gcc.gnu.org/onlinedocs/

But knowing you I know you will not bothered to read it and come
again with the same question asked differently. You are starting to
be a nuisance on this list.

--
					    Gilles.

