From: Lowell Gilbert <kludge@be-well.ilk.org>
Subject: Re: problems opening files without auto-init
References: <44h8adetpj.fsf@be-well.ilk.org>
Date: Wed, 01 May 2019 17:55:42 -0400
In-Reply-To: <44h8adetpj.fsf@be-well.ilk.org> (Lowell Gilbert via Xenomai's
 message of "Wed, 01 May 2019 17:43:52 -0400")
Message-ID: <44d0l1et5t.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Lowell Gilbert via Xenomai <xenomai@xenomai.org> writes:

> I disabled auto-init to be able to fork my daemon process, but now I
> can't open a file, whether it's before or after I call xenomai_init().

The errno is EPERM.

