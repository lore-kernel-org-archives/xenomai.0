References: <cover.1518525088.git.henning.schild@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <309d5e87-c219-837b-c5f0-d87b3b04454a@xenomai.org>
Date: Tue, 20 Feb 2018 10:26:40 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1518525088.git.henning.schild@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0/3] debian/ realted changes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 02/13/2018 01:38 PM, Henning Schild wrote:
> The first one actually fixes a regression where debian packages can not
> be generated anymore. And the remaining two fix minor issues.
> 
> Henning Schild (3):
>   debian: drop prebuild docs from packages
>   debian: add mssing build dependency
>   debian: increase debian compat level
> 
>  debian/compat                  |  2 +-
>  debian/control                 | 25 ++++---------------------
>  debian/xenomai-doc.install     |  1 -
>  debian/xenomai-runtime.install |  1 -
>  4 files changed, 5 insertions(+), 24 deletions(-)
>  delete mode 100644 debian/xenomai-doc.install
> 

Merged, thanks.

-- 
Philippe.

