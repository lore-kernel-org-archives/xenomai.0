MIME-Version: 1.0
Date: Thu, 9 Oct 2014 01:08:05 +0300
Message-ID: <CANgF67QfJfNi+NwHKvibymddbGhjqPZb6Gxjag4myQGskJe_0A@mail.gmail.com>
From: agnes jurek <agnessjurek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] undefined reference to `rt_printf'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I tried to execute a rxenomai tdm example
<http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html>. There are
all step for compilinig this code.

But when I run "xeno-config --xeno-cflags" and "xeno-config --xeno-ldflags"
, it said that   "--xeno-cflags is deprecated, use --skin=name --cflags".So
I used "xeno-config  --skin=native --cflags" and "eno-config  --skin=native
--ldflags".


 But When I run gcc $CFLAGS $LDFLAGS  -lnative -lrtdk  ex01.c -o ex01  , I
got error message "undefined reference to `rt_task_create'"
