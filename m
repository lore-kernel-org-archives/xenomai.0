Message-ID: <526AEA7E.6030801@xenomai.org>
Date: Sat, 26 Oct 2013 00:02:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Reworking forge FPU switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Hi,

after testing a few ideas to avoid useless fpu save/restore, I came to
the changes in the following patches. I tried to split the changes in
many patches to simplify review. The ARM changes are not included, they
are not finished yet, and the critics to the changes in the generic
parts may entail some changes for ARM.

Regards.

-- 
                                                                Gilles.

