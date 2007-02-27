MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HYYEO9bJC6"
Content-Transfer-Encoding: 7bit
Message-ID: <17892.39850.482375.823627@domain.hid>
Date: Tue, 27 Feb 2007 21:59:22 +0100
Subject: Re: [Xenomai-help] task not being scheduled
In-Reply-To: <45E494AC.5050603@domain.hid>
References: <45E478BB.40301@domain.hid> <200702271404.59477.jweber@domain.hid>
	<45E494AC.5050603@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>, Jeff Weber <jweber@domain.hid>


--HYYEO9bJC6
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
 > Jeff Weber wrote:
 > > trace and .config attached.
 > 
 > OK. Sorry for not believing in the first place :), but there are
 > actually timer events missing for your 10-ms-period task.
 > 
 > I saw in the .config that you are using the heap timer list. Already
 > tried the classic linked list as well? Maybe we see in issue related to
 > this queue implementation.
 > 
 > Gilles, I think the heap was your contribution. If it turns out to bite
 > us here, any idea where to look, what to instrument
 > (xntrace_special[_u64]...)?

I used a dumper that I called at any time when I wanted to inspect the
contents of a binary heap. Here it comes, it probably needs to be
re-adapted.

-- 


					    Gilles Chanteperdrix.

--HYYEO9bJC6
Content-Type: text/plain
Content-Disposition: inline;
	filename="aheap_dump.h"
Content-Transfer-Encoding: 7bit

#ifndef AHEAP_DUMP_H
#define AHEAP_DUMP_H

#ifndef __KERNEL__
#include <stdlib.h>             /* For NULL */
#include <errno.h>              /* For EINVAL, EBUSY */
#include <string.h>             /* For memset */
#endif /* __KERNEL__ */

#if DUMPER && !defined(__KERNEL__)
#define flnz(word)                              \
({                                              \
    unsigned long out;                          \
    /* Derived from bitops.h's ffs() */         \
    __asm__ ("bsrl %1, %0"                      \
             : "=r" (out)                       \
             : "mr"  (word));                   \
    out;                                        \
})

static inline void
aheap_dumper_visit (FILE *file,
                    aheap_t *heap,
                    aheaph_t *node,
                    int (*prn)(char *, size_t, const aheaph_t *const),
                    const char *blank,
                    unsigned blank_sz,
                    char *buf,
                    unsigned indent,
                    unsigned len)
{
    aheaph_t *left, *right;

    right = aheaph_child(heap, node, 1);
    if(right) {
        if(blank_sz >= (unsigned) (buf-blank)) {
            snprintf(buf, len+2, "%*s\n", (int) len+1, "bug!");
            fputs(buf-blank_sz, file);
        } else
            aheap_dumper_visit(file, heap, right, prn, blank,
                               blank_sz+indent, buf, indent, len);
    }
    
    (*prn)(buf, len+1, node);
    buf[len] = '\n';
    buf[len+1] = '\0';
    
    fputs(buf-blank_sz, file);

    left = aheaph_child(heap, node, 0);    
    if(left) {
        if(blank_sz >= (unsigned) (buf-blank)) {
            snprintf(buf, len+2, "%*s\n", (int) len+1, "bug!");
            fputs(buf-blank_sz, file);
        } else
            aheap_dumper_visit(file, heap, left, prn, blank,
                               blank_sz+indent, buf, indent, len);
    }
}

static inline void
aheap_dump (FILE *file,
            aheap_t *heap,
            int (*prn)(char *, size_t, const aheaph_t *const),
            unsigned indent,
            unsigned len)
{
    aheaph_t *holder = aheap_gethead(heap);

    putc('\n', file);
    if (!holder)
        fputs("Empty.\n", file);
    else {
        size_t blank_sz = (flnz(heap->last - 1) + 1) * indent;
        char buffer[blank_sz+len+2];
        memset(buffer, ' ', blank_sz);

        aheap_dumper_visit(file, heap, holder, prn, buffer, 0,
                           buffer+blank_sz, indent, len);
    }
}
#else /* !DUMPER || __KERNEL__ */

#define aheap_dump(file, heap, prn, indent, len) do { } while(0)

#endif /* !DUMPER || __KERNEL__ */

#endif /* AHEAP_DUMP_H */

--HYYEO9bJC6--

