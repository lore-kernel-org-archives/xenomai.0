References: <447fdp9oue.fsf@be-well.ilk.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0b7ab1b8-8d53-069a-49b6-a3f289c0b43c@xenomai.org>
Date: Sat, 18 Jun 2016 15:29:22 +0200
MIME-Version: 1.0
In-Reply-To: <447fdp9oue.fsf@be-well.ilk.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] slackspot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>, xenomai@xenomai.org

On 06/16/2016 04:43 PM, Lowell Gilbert wrote:
> I have been unable to use slackspot, because /proc/xenomai/debug/relax
> is empty. I do have CONFIG_XENO_OPT_DEBUG_TRACE_RELAX enabled (without
> that enabled, I don't even have the file).

This is expected.

 I have not run /bin/relax,
> mentioned in the manual page, because I don't have such a program and
> can't find any reference to it.
> 
> I am using 3.0.2.


/bin/relax is only the name of a fake executable that would have
produced the typical output described in the example, read /foo/bar if
that helps.

Once TRACE_RELAX is enabled in the kernel, running any application that
causes switches to secondary mode should populate
/proc/xenomai/debug/relax with event records.

-- 
Philippe.

