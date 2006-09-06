MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ro6yQQHAk7"
Content-Transfer-Encoding: 7bit
Message-ID: <17662.49530.72472.462058@domain.hid>
Date: Wed, 6 Sep 2006 14:39:22 +0200
Subject: Re: AW: [Xenomai-help] resubmission : memset of heap crashes
	Xenomai-Task
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A4E9CDD@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2A4E9CDD@ARVMAIL1.mra.roland-man.biz>
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org


--ro6yQQHAk7
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Roderik_Wildenburg@domain.hid wrote:
 > Dear Gilles,
 > 
 > I admit, the mechanism for allocating all memory of the target is not very sophisticated. The idea was, that MAXHEAPBLOCKS*MEMORYCHUNKSIZE is much much more, than memory available (at least with my target (128MB) this is true). I should have mentioned this in the source code, sorry. If your target has more then (MAXHEAPBLOCKS*MEMORYCHUNKSIZE=320MB(approcimate)) memory, you should increase MAXHEAPBLOCKS.
 > 
 > If this condition is fulfiled, I think, there should be no illegal memory access. Do you agree ?
 > 

A better patch.

-- 


					    Gilles Chanteperdrix.

--ro6yQQHAk7
Content-Type: text/plain
Content-Disposition: inline;
	filename="roderik-heap.diff"
Content-Transfer-Encoding: 7bit

--- heap.c~	2006-09-06 14:27:31.000000000 +0200
+++ heap.c	2006-09-06 14:37:07.000000000 +0200
@@ -101,7 +101,15 @@ void display(void *cookie)
    {
       memsize+=addsize;
       if(!(ret=rt_heap_create(&bigheap[i],nbuf,memsize,H_PRIO|H_MAPPABLE)))
+      {
+	 if (i > MAXHEAPBLOCKS - 1)
+	 {
+	    printf("i= %d is out of bounds, stopping here, avoid later SEGV.\n",
+		   i);
+	    exit(EXIT_FAILURE);
+	 }
          rt_heap_delete(&bigheap[i]);
+      }
    }while(ret==0);
 
    memsize>>=1;

--ro6yQQHAk7--

