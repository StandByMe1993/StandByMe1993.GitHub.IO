<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.authoricon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

{% if theme.copyright %}
<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" rel="nofollow" href="https://pages.github.com/">GitHub Pages</a>') }}
</div>

<div class="theme-info">
  内容 -
  <a class="theme-link" href="https://StandByMe.IO">StandByMe.IO</a>
</div>
{% endif %}
