References: <AM4PR05MB17479649FDCD91F251E66DB991740@AM4PR05MB1747.eurprd05.prod.outlook.com>
 <37e28fa0-0e14-6b84-dc43-e0f64c16c226@xenomai.org>
 <AM4PR05MB17470B585705C4680E3DF0EC915C0@AM4PR05MB1747.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <de32dcc4-3237-3686-779d-3cdf280eba2d@xenomai.org>
Date: Tue, 7 Jun 2016 17:03:24 +0200
MIME-Version: 1.0
In-Reply-To: <AM4PR05MB17470B585705C4680E3DF0EC915C0@AM4PR05MB1747.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] what limits number of pSOS tasks using t_create?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marcel Van Mierlo <Marcel.VanMierlo@marel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Hi,

On 06/06/2016 10:14 AM, Marcel Van Mierlo wrote:
> 
> Hi Philippe, yes that worked.
> 
> I made a regression test on the maximum number of psos threads I could create. I found that once I start seeing ERR_NOTCB returned from t_create the maximum number of tasks I can create then drops, even after deleting all previous tasks - as if available memory for tasks becomes less after limit is hit.
> 
> For example, after tuning all four parameters below (including CONFIG_XENO_OPT_REGISTRY_NRSLOTS) I am able to reliably create 500 tasks under test conditions - if I push it to 600, say, and see ERR_NOTCB, then after deleting all tasks I can only create a maximum of around 300 tasks.
> 
> This is fine for me - I know I will never need more than 150 tasks, but seems something worth noting.
> 

I cannot reproduce that one yet. A few questions:

- are you starting the tasks or only creating them before calling
t_delete() on the tid?

- do you observe this behavior when respawning the test program after
each creation+deletion sequence, or within a single execution of the
test program running multiple sequences?

- can you paste the output of ./your_program --dump-config?

Thanks,

-- 
Philippe.

