References: <56377A74.6020803@mail.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56377FFE.7010509@xenomai.org>
Date: Mon, 2 Nov 2015 16:23:42 +0100
MIME-Version: 1.0
In-Reply-To: <56377A74.6020803@mail.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel oops in giveup_fpu (file fpu.S)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ralf Moder <ralf.moder@mail.de>, xenomai@xenomai.org

On 11/02/2015 04:00 PM, Ralf Moder wrote:

> Is this the right way to solve this problem? 

Please try that patch instead:

http://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.14&id=14665691d7e387d33a9b15774e541121aa513c27

-- 
Philippe.

