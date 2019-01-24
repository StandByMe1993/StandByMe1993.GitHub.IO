{# Social Links #}
{% include "./_footer/social.swig" %}

<div class="copyright">
  <span class="power-by">
    <a class="hexo-link" rel="nofollow" href="https://StandByMe.io/">StandByMe.io</a>
  </span>
  <span class="division">|</span>
  <span class="theme-info">
    <a class="theme-link" target="_blank" href="https://standbyme.io/sitemap.xml">站点地图</a>
  </span>

  <span class="copyright-year">
    {% set current = date(Date.now(), "YYYY") %}
    &copy; 
    {% if theme.since and theme.since != current %} 
      {{ theme.since }} - 
    {% endif %}
    {{ current }}

    <span class="heart">
      <i class="iconfont icon-heart"></i>
    </span>
    <span class="author">{{ config.author }}</span>
  </span>
</div>
