MIME-Version: 1.0
Date: Sun, 8 Feb 2015 20:20:54 -0600
Message-ID: <CA+C+_XRGJinM4nkPutZMO5ZUOEz9tFKhQww2_DOuM+PJquvVXQ@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] segfault
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I have a program thats segfaulting when I add additional real time threads
that each take up resources.  By themselves or in small groups, they're
fine.  But as I scale it up, it crashes.  I haven't got gdb to work right
yet, so it crashes in such a way that prevent me from pulling any debug
information out.  I ran dmesg, but don't see anything meaningful.  Are
there other logs I can look at?
